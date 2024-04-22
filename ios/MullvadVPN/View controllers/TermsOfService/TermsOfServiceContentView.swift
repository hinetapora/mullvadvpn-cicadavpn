//
//  TermsOfServiceContentView.swift
//  MullvadVPN
//
//  Created by pronebird on 28/04/2021.
//  Copyright © 2021 Mullvad VPN AB. All rights reserved.
//

import UIKit

class TermsOfServiceContentView: UIView {
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.darkGrayColor
        titleLabel.allowsDefaultTighteningForTruncation = true
        titleLabel.text = NSLocalizedString(
            "PRIVACY_NOTICE_HEADING",
            tableName: "TermsOfService",
            value: "Welcome to the CicadaVPN!",
            comment: ""
        )
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.lineBreakStrategy = []
        return titleLabel
    }()

    let bodyLabel: UILabel = {
        let bodyLabel = UILabel()
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.font = UIFont.systemFont(ofSize: 18)
        bodyLabel.textColor = UIColor.darkGrayColor
        bodyLabel.numberOfLines = 0
        bodyLabel.text = NSLocalizedString(
            "PRIVACY_NOTICE_BODY",
            tableName: "TermsOfService",
            value: "Your privacy matters. Our VPN app encrypts your data, ensuring no logging or tracking of your online activities. Stay secure with us.",
            comment: ""
        )
        return bodyLabel
    }()

    let privacyPolicyLink: LinkButton = {
        let button = LinkButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleString = NSLocalizedString(
            "PRIVACY_POLICY_LINK_TITLE",
            tableName: "TermsOfService",
            value: "Privacy policy",
            comment: ""
        )
        button.setImage(UIImage(named: "IconExtlink"), for: .normal)
        return button
    }()

    let agreeButton: AppButton = {
        let button = AppButton(style: .success)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "AgreeButton"
        button.setTitle(NSLocalizedString(
            "CONTINUE_BUTTON_TITLE",
            tableName: "TermsOfService",
            value: "Agree and continue",
            comment: ""
        ), for: .normal)
        return button
    }()

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let scrollContentContainer: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.directionalLayoutMargins = UIMetrics.contentLayoutMargins
        return contentView
    }()

    let footerContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.directionalLayoutMargins = UIMetrics.contentLayoutMargins
        container.backgroundColor = .secondaryColor
        return container
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func addSubviews() {
        addSubview(scrollView)
        addSubview(footerContainer)

        scrollView.addSubview(scrollContentContainer)
        [titleLabel, bodyLabel, privacyPolicyLink].forEach { scrollContentContainer.addSubview($0) }
        footerContainer.addSubview(agreeButton)

        scrollView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        footerContainer.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            scrollContentContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            scrollContentContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContentContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContentContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            footerContainer.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            footerContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerContainer.bottomAnchor.constraint(equalTo: bottomAnchor),

            agreeButton.topAnchor.constraint(equalTo: footerContainer.layoutMarginsGuide.topAnchor),
            agreeButton.leadingAnchor
                .constraint(equalTo: footerContainer.layoutMarginsGuide.leadingAnchor),
            agreeButton.trailingAnchor
                .constraint(equalTo: footerContainer.layoutMarginsGuide.trailingAnchor),
            agreeButton.bottomAnchor
                .constraint(equalTo: footerContainer.layoutMarginsGuide.bottomAnchor),

            titleLabel.topAnchor
                .constraint(equalTo: scrollContentContainer.layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor
                .constraint(equalTo: scrollContentContainer.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor
                .constraint(equalTo: scrollContentContainer.layoutMarginsGuide.trailingAnchor),

            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            bodyLabel.leadingAnchor
                .constraint(equalTo: scrollContentContainer.layoutMarginsGuide.leadingAnchor),
            bodyLabel.trailingAnchor
                .constraint(equalTo: scrollContentContainer.layoutMarginsGuide.trailingAnchor),

            privacyPolicyLink.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 24),
            privacyPolicyLink.leadingAnchor
                .constraint(equalTo: scrollContentContainer.layoutMarginsGuide.leadingAnchor),
            privacyPolicyLink.trailingAnchor
                .constraint(
                    lessThanOrEqualTo: scrollContentContainer.layoutMarginsGuide
                        .trailingAnchor
                ),
            privacyPolicyLink.bottomAnchor
                .constraint(equalTo: scrollContentContainer.layoutMarginsGuide.bottomAnchor),

        ])
    }
}
