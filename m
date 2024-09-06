Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDA61D1F60
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637414; cv=none; b=CHRv29SdBAKEsrOedg+azHxTwFRe9tIFkmD6MPv7h0y1fTCx7z3Ch82p6AUp3QVrMDpfXt9WHS+xNkJb+ycDqP9r4lprEGniJ2kqz1vMmeTi8AsxT8HnLIsyApeZYGr6yXL9sOL0lB5DtB2WdMXBFnvMMYpSy9FWFEWc4kOwlCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637414; c=relaxed/simple;
	bh=SdA/884OUoNUTYfuujZhiUv6gnTpSFyrP/yZXl0aWnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FL82W0brpvxK6n+uDHy4PTDDFsRqJmfjwTtE4w5O7K0mWfl42sPs1bTcjfZl5uCLSgSnTmza2pWw3PRxs5b6RECJ1MlmOmS2WfSq6Ia34r8H8dW3xMEN2c+Usf5VM6lFSaYZb8ThBtnle+Si+oqvSllPYCeXIhS2b/LU0YL4Tbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JJWaAhY0; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JJWaAhY0"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c3c30e663fso2563178a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Sep 2024 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725637409; x=1726242209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MjmPcGq5VFRg/trcWFAfLiT2RKaNRMYo+KytcVSszMU=;
        b=JJWaAhY0QmaTMLT96CI2f29sT2rNEnQQ6zEffvV5QkXqD214MkH2/XVc5Y5Cq3Kbjz
         IS0/jEu4vEQy+Khl9xpkGtDecYYyQNBZq6+k96MDaxR2F8xR4u4vLMGX6HEKNzKiJUNJ
         4DuMEu7rfctIGTAD9D8KKYvoPfR2xQNuTLuvIt5p8qvyRgC67GBDX+X3lkHNIsjKapHQ
         MYFpmst0CxU0L3JemfnTH8tcOEVX15hXysOdvvNWNJ662VGNYWunx1/iTIFTPWXgDaor
         UXPUrFTwsTslHQEbyTLUvQn1TXeQG/9HqOMDAAeI20T8SaqTNDfQzfieZYaXX9OExkIA
         WGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725637409; x=1726242209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MjmPcGq5VFRg/trcWFAfLiT2RKaNRMYo+KytcVSszMU=;
        b=hcbiyHSGUeUu1+eo/sFWmi/Rlk2e0cFGg52yguGDQ8lwY9vmBZuupJFVIKVSlou05Y
         +Fbzy2L8k/l9A9sbL57XfI5cVZtgsYqYTd+su2CJ/RTWUW8sdDUG1w6e6IsetozpVhks
         OQDddj7acgL94pnGHepICNgZW1M4600u2BV/i5z5WgnPrbOYfGKchiWT34lNM1P3SJVE
         G/WC2F1lzLiTPsQpOVCPH5A3LT/W3ZcITw9CsfKpON+Y5WpAmlmVgPSE4AYms/Oaykbq
         8Acw97HWEMuLjrw0gdvWbT4JGiGcC0RnTUKXhEXvveviUMEpsmJLQYqavFxwxfLs2HOo
         ID+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmywSbiDeoZ5UOBKt7sWMZdzuu2y4vWgc+kOzoQApOWrXZAvWCBGmWgsdoj7NXXavlAu6c7NDWQUDnPWITa+ckiLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhlcQilnoSZTCvLtdffcZPMBfMML4oDADbNU3YMx2shXSx/x4m
	/JmX3t8GWyEbFnnBWOt2pD2L95xuoXKQf/i39LQ/feZhr0kh0lpbst16S2FhLqmB32BkOXBkTC2
	8
X-Google-Smtp-Source: AGHT+IH8H7wUCUtT2JdrUvSGz7620gDLCP1Ri6GgPWlKZPRqpIXr9jqxs/IkSkJ8Y41lHToBIGDC2w==
X-Received: by 2002:a05:6402:26d5:b0:5c2:4eb3:e806 with SMTP id 4fb4d7f45d1cf-5c3dc7b800bmr1963773a12.24.1725637408823;
        Fri, 06 Sep 2024 08:43:28 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc52d989sm2649933a12.3.2024.09.06.08.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 08:43:28 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Kent Gibson <warthog618@gmail.com>,
	David Lechner <dlechner@baylibre.com>
Subject: [PATCH v4 0/7] pwm: New abstraction and userspace API
Date: Fri,  6 Sep 2024 17:42:56 +0200
Message-ID: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4753; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=SdA/884OUoNUTYfuujZhiUv6gnTpSFyrP/yZXl0aWnQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm2yMBIjjylPYTGgYkClNl3CRKRJzeGv/xfaGKZ M3/knRNgdKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZtsjAQAKCRCPgPtYfRL+ TkuHB/4oOdPXE/Nvd7VgU9doI8Iqc2fEhA8GrLjwN2ob+zZ/S/Q5Ie7RC8D6yN8IBSsYzZznPOi /g9AKLEAmsuisG4ynZ4y5bIA3vuguPHyvGTGbcSF/Q/+biJUSMsF6Um4kcIk4lfmIcrmfZa4yqv WeBA95Lg63Zgld7o7gpFMx2J8VXUUKqk0eCiuGYTxb8GqdvUhQxYUFb1UWcq0mV2ZupcTOCnHgR ibMxH/VWqLoqpny0m2mxWwFD8LCn3eklOEt+UbDR6kmxYxNpGplghFNubOlaSCxDg0Dq2hDw+L3 5/rlTqh6RO+nZO4DvuWWQ+4ufL+GvuWLZb35RP8BVfAFQxdF
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

here comes v4 of the series to add support for duty offset in PWM
waveforms. For a single PWM output there is no gain, but if you have a
chip with two (or more) outputs and both operate with the same period,
you can generate an output like:

               ______         ______         ______         ______
   PWM #0  ___/      \_______/      \_______/      \_______/      \_______
                 __             __             __             __
   PWM #1  _____/  \___________/  \___________/  \___________/  \_________
              ^              ^              ^              ^

The opportunity for a new abstraction is/should be used to also improve
precision of the API functions, which implies that the rules for
lowlevel drivers are more strict for the new callbacks.

Changes since v3, which is available from
https://lore.kernel.org/linux-pwm/cover.1722261050.git.u.kleine-koenig@baylibre.com/
include:

 - Drop PWM_IOCTL_GET_NUM_PWMS ioctl (patch #4), suggestion by David
   Lechner

 - Define members of userspace API struct using __u32 instead of
   unsigned int; thanks to Kent Gibson for the suggestion (patch #4)

 - Ensure that pwm_apply_state_{atomic,might_sleep}() don't return 1
   Noticed by Fabrice Gasnier

 - Rebased to current pwm/for-next.
   (fixing a missing +1 noticed by Fabrice)

 - Dropped Tested-by: from Trevor
   While the axi-pwmgen driver didn't change, there were considerable
   changes in the core. So I dropped it.

 - add some missing EXPORT_SYMBOL_GPL for the new API functions

 - Add kernel doc comments for the new API functions

 - debug message in stm32_pwm_round_waveform_fromhw (another suggestion
   by Fabrice)

I also updated the branch pwm/chardev in
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git to
match this v4.

I'm aware of two issues in this series:

 - Triggers a lockdep warning in the pwm-meson driver. This affects the
   new pwm locking vs the clk framework's prepare lock. I think this is
   a false positive and to fix it, only changes in the clk framework are
   necessary.

 - The functions pwm_set_waveform_might_sleep() and
   pwm_round_waveform_might_sleep() have an unusual return value
   convention: They return 0 on success, 1 if the requested waveform
   cannot be implemented without breaking the rounding rules, or a
   negative errno if an error occurs.
   Fabrice rightfully pointed out this to be surprised by this and
   suggested to use at least a define for it.

   I couldn't find a decision that I'm entirely happy with here. My
   conflicts are:

    - I want a constant that now and in the future only means "cannot be
      done due to the rounding rules in the pwm framework". So the
      options are:
        * Introduce a new ESOMETHING and return -ESOMETHING
          I think that's hard to motivate and also myself doubt this
          would be sensible. As below, the question for a good name is
          unresolved.
        * return 1
          This is what was done in the earlier revisions and also here.

    - When keeping the return 1 semantics (and also for a new
      ESOMETHING):
      I agree that a name instead of a plain 1 would be nice, but I
      couldn't come up with a name I liked. Given that this can be
      introduced later without breaking anything, I don't consider that
      very urgent.
      My candidates were PWM_REQUIRES_BROKEN_ROUNDING,
      PWM_REQUIRES_FORBIDDEN_ROUNDING and PWM_ERR_ROUNDING.
      These are too long or/and imprecise.
      If you have a good idea, please tell.

Still I'd like to get that forward and (unless a new and relevant issue
pops up until then) intend to put it into next after the next merge
window. Nevertheless I'm open for suggestions to further improve this
series.

Best regards
Uwe

Uwe Kleine-König (7):
  pwm: Add more locking
  pwm: New abstraction for PWM waveforms
  pwm: Provide new consumer API functions for waveforms
  pwm: Add support for pwmchip devices for faster and easier userspace
    access
  pwm: Add tracing for waveform callbacks
  pwm: axi-pwmgen: Implementation of the waveform callbacks
  pwm: stm32: Implementation of the waveform callbacks

 drivers/pwm/core.c           | 867 +++++++++++++++++++++++++++++++++--
 drivers/pwm/pwm-axi-pwmgen.c | 154 +++++--
 drivers/pwm/pwm-stm32.c      | 612 ++++++++++++++++---------
 include/linux/pwm.h          |  58 ++-
 include/trace/events/pwm.h   | 134 +++++-
 include/uapi/linux/pwm.h     |  24 +
 6 files changed, 1545 insertions(+), 304 deletions(-)
 create mode 100644 include/uapi/linux/pwm.h

base-commit: cf6631b07b907d4c644ca42f7cc234e7149290a2
-- 
2.45.2
