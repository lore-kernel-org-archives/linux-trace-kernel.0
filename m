Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C614513C8E2
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726822721; cv=none; b=W+2yXJvDIwK8M2M6Hc7xVy1z+EA75076dd/aT6nLw4nx8lDvQUcMS/80P3qTOd3Qq5Vfv7ea9Jxgk4BfKXRwYXZhoTfLvxqJR13uAn6YzHvohof+zOD7RhMdU0KjzqGWAcp0k7yKP/O+nMwtWsfij5BQVQEVoGmAdakv8OnRyzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726822721; c=relaxed/simple;
	bh=te+EbZlOUzUoKfESPB4idPRylkC8d1cHg4R/EUUCx30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PGE0OTCfaxONz+4dWxBKAodi+biXCS+Bnz1F6ObF8WbIZdZtwNmJT2p49shOYh8MD91YCUkXZIO9IiB0XT2SkBo9J1MaHAEJ6dUc8QJbiy68UvwaIx4t8DPAOjzrOPFKa/YCNALhTY91zbGAmGb2gPLhu0JUENUIZ6FrCoKPORI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Td96Na4s; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Td96Na4s"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42e5e758093so15532375e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Sep 2024 01:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726822714; x=1727427514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5T7rAchj5qjYDoyRW1lduedlZlpub5pg2seiU2N4rAs=;
        b=Td96Na4s2MzDQgbaTwc/3HOiMnxDMhleVrin2asGCLw+ZX0KOr+w7qbgAxWQ8ovxLL
         2xlGOTMd3uWVPpSDvHYwjC6Rmybh1wA6RU6t8tFaztQxDvbbALgQ/3LsYtAR8E7F7Ph/
         fBQQ/mzEb7tHMbitMPs0e0CS2mYqdwsunfoAPTMT60tzZBUsCIzaVevcAFmLVsy7vG/a
         T5Eok0Ydtt9FFwWJ+mp/xd3R+dJwom0UlwqqBNHQLiHzSl/9h+q2UKx08zpRuaKwBNUJ
         rCp7ecp5mebw1IxQkp9UerbZ4pWdgoAon9bacWiPa4mSWh2fO73QP42Lseq2eIXWmXDj
         Ey6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726822714; x=1727427514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5T7rAchj5qjYDoyRW1lduedlZlpub5pg2seiU2N4rAs=;
        b=rH48TRKOb49B0pQqnxgqlnE9xtNU4CRVgHP2i4ryyV1umEZ+JFyC2fHgtsES8TJBYb
         9WXW9pk+C3yXNfuuIYPkjlGYFKtCBSZ0/y4ZLjv6L8PrlgeIqYFby1Fz3kaC+l2VEvkF
         6NY5YZzrZffhpzECb79nHwIlVX/gqwQP3+n/Tryp3dqYsvrtheNrlzk2xaUK01mAiqUl
         Vb9fF/wiRbBJTCkzWdTl2cvFe7vEFaCQsRBiYWyZxWkKaFAcFJrke07VuK/gcDZLHDPY
         lIQBjj69WCIXRdUANC4qUFMNoQvT0YysP0B23FxKNWqROggcJzSHARzUw+V5lCJ3a+6o
         EvGA==
X-Forwarded-Encrypted: i=1; AJvYcCVtbaZ/0ryIrfcSLjVuDMM/GHGcRmEbZ5XdzWsiP1K0hpGBo6fNVbbVgx3cwbDikaj+/WPzGECUMmf4lGyPGuP1WeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI/NVkXm79feUs3+kTpSx/UZoEHN9+l/kUSPxEXVSfmZ9eGd+t
	6U3/32dFdfwU8V/dbDXSm1YCQ1/IIreQWAoj0XLy6bF6Jezy+NBYDdIzLNODWkQ=
X-Google-Smtp-Source: AGHT+IFiyYUeet0rXnG7rQ+wSp502xhgfbMgHAX8ZnoNks935ZvuxAODvTuqZ89H56rGe8FXixFBRQ==
X-Received: by 2002:a5d:6646:0:b0:378:89d8:8242 with SMTP id ffacd0b85a97d-37a422bf176mr1194672f8f.26.1726822714017;
        Fri, 20 Sep 2024 01:58:34 -0700 (PDT)
Received: from localhost (p200300f65f01db004d6a46a6454a1385.dip0.t-ipconnect.de. [2003:f6:5f01:db00:4d6a:46a6:454a:1385])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71f060bsm17253187f8f.1.2024.09.20.01.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 01:58:33 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Kent Gibson <warthog618@gmail.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/8] pwm: New abstraction and userspace API
Date: Fri, 20 Sep 2024 10:57:56 +0200
Message-ID: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4775; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=te+EbZlOUzUoKfESPB4idPRylkC8d1cHg4R/EUUCx30=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm7TkV/hf2RR9pvgUEH/B4lFQkjy6tkOym4gxCC vSZyuCbZu2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZu05FQAKCRCPgPtYfRL+ Tvt+B/9MeZwymukRVIoG7lg3WRNuWiKios+vhDimsAp5YqaQUrWoPlJXQQQE3OxiVqTlfEWmIWZ RMfLrxP51RUnl2ohTkJ2+UWZypzOdCyQ9SqPuz+m7pYTSxhEAKnN76IDUK4FFhfgCup/PwG4Xx8 02m8ui24J/3AO/9F0mkibyoI2xseAU4DUMdUUU8pDTFeGzI0E6+r/uu9cxc+hXEE4CkGIy7Lis+ CK+7e5KbyBw/Nu2djwDD/lUFniw6PqVcXqHTQuMq/ESlAtHzU9zYEsku8b6DFEiQV/ljUZ6FzkL p29TKSASh7D360Iquptb5Pg/WKyZTmMf+mMitPW3UmG8bthV
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

here comes v5 of the series to add support for duty offset in PWM
waveforms. With that (and using two PWMs of a single chip) the following 
waveform pair can be configured:

               ______         ______         ______         ______
   PWM #0  ___/      \_______/      \_______/      \_______/      \_______
                 __             __             __             __
   PWM #1  _____/  \___________/  \___________/  \___________/  \_________
              ^              ^              ^              ^

This is required for an adc driver by Trevor Gamblin[1]. The last patch
also adds a new userspace API using a character device per pwm_chip (if
the underlaying lowlevel driver support the new waveform callbacks).
Compared to the earlier revisions of this series it was moved to the
last patch because I don't intend to apply it during the next
development cycle. The reason that makes me hesitate is that the return
value convention by the .round_waveform_tohw() callback is unusual: It
returns either 0 or 1 or a negative error value. These return values are
passed to userspace as the return value of the added ioctl() calls and
so are not changable any more once they are considered part of the
userspace API. So for now the pwm internal convention stays unusual as
it was before, but can still be easily adapted if practise showed the
convention to be too bad to keep.

If you want to test this series, the current state is available at
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/chardev
.

Changes since v4 which is available at
https://lore.kernel.org/linux-pwm/cover.1725635013.git.u.kleine-koenig@baylibre.com
:

 - As described above: New patch to reorder symbols in core.c and the
   character device patch is moved to the end.

 - PWM_IOCTL_REQUEST is now mandatory before using a pwm device via the
   pwmchip character device. Thanks to David for input here.
   The libpwm repo[2] is updated accordingly.

 - PWM_IOCTL_REQUEST and PWM_IOCTL_FREE calling convention changed.
   Before you had to do:

	someuint = 3;
	ioctl(pwmchipfd, PWM_IOCTL_REQUEST, &someuint);

   Now it's just:

	ioctl(pwmchipfd, PWM_IOCTL_REQUEST, 3);

 - There is a new patch that reorders functions in drivers/pwm/core.c.
   The motivation for that was a locking issue in the ioctl code where
   pwm_lock was taken twice on PWM_IOCTL_FREE. So a new variant of
   pwm_put() was introduced that relies on the caller to have grabbed
   the lock already. To not have to declare this new function, it had to
   be moved further up in core.c

 - Some debugging code removed. (huh, thanks to David for noticing.)

 - Additions to comments (also kernel doc) and commit logs for several
   patches to (hopefully) make things clearer.

 - Refactored how the input is validated for the PWM_IOCTL_SET*WF
   ioctls to remove code duplication. (IIRC this was feedback on an
   earlier revision. But I only remembered it and couldn't find it in my
   mailbox. I think it was Fabrice who wrote that, but I'm not entirely
   sure. Thanks to whoever it was.)

Unless something grave pops up, I intend to add this series (without the
last patch) to next after the merge window closes to give it some more
exposure and testing. I'm pretty sure the code still has to be fixed and
improved here and there, but I will do that in-tree then. Once I'm sure
it will go in, I'll create a tag for Jonathan to merge into his iio tree
to allow him to apply Trevor's adc driver.
@Jonathan: What's your desired timing? I'd target for around -rc3 time
to create that tag for you. Is that early enough for you?

Best regards
Uwe

[1] https://lore.kernel.org/linux-iio/20240909-ad7625_r1-v5-0-60a397768b25@baylibre.com
[2] https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.git

Uwe Kleine-König (8):
  pwm: Add more locking
  pwm: New abstraction for PWM waveforms
  pwm: Provide new consumer API functions for waveforms
  pwm: Add tracing for waveform callbacks
  pwm: axi-pwmgen: Implementation of the waveform callbacks
  pwm: stm32: Implementation of the waveform callbacks
  pwm: Reorder symbols in core.c
  pwm: Add support for pwmchip devices for faster and easier userspace access

 drivers/pwm/core.c           | 1144 +++++++++++++++++++++++++++++-----
 drivers/pwm/pwm-axi-pwmgen.c |  154 +++--
 drivers/pwm/pwm-stm32.c      |  612 +++++++++++-------
 include/linux/pwm.h          |   58 +-
 include/trace/events/pwm.h   |  134 +++-
 include/uapi/linux/pwm.h     |   32 +
 6 files changed, 1693 insertions(+), 441 deletions(-)
 create mode 100644 include/uapi/linux/pwm.h

base-commit: d242feaf81d63b25d8c1fb1a68738dc33966a376
-- 
2.45.2
