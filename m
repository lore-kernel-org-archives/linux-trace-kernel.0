Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FC11E487C
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Aug 2024 11:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031525; cv=none; b=XElRtqK1oYd32XR2sGRkXzGPWhUJmwYM7nJm0pzqnhDoTXLhCowqRwgEHkOMfbjqjsGlq4imPZeMsuBsJZ0GuO+l6nXih9F38+TedDQCvmOo5YPQI5kgoVDfQ6gDWCfhiSdfeXqv6dbqkCSPlEh4+2EZZvOCN4URGHTDbCIFCos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031525; c=relaxed/simple;
	bh=9B9fFFzYSwPitp9GfQDLKcClcUFO81KZbMRhTSB3oRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NPsK/+03Y4M21WARKWOzUOEyJuuOY9QeDIERtdeLwCbosrZXv1xAa+whmEl+mlqgJ5XyEewcb1BgpP63/JrModTs0M2iygxIOHGcODQDH5nkvTf5Jg7MHeIoro4dZJga3opwqsu4AYTM9IjRgsO1Ghaflgn7V4kg1l30/tXlFiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=mkYRom0Y; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="mkYRom0Y"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5bb8e62575eso867823a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Aug 2024 04:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1723031521; x=1723636321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H9r0PfsFmuHqo6aX99isTmX4uf0XE2oPjBUWCfq0gn8=;
        b=mkYRom0YWG1xpHkrQw/sZnIqbbNBT5+aQBhry+BfHfYA2ippRYOnqG6o12DkwmoBit
         8DZI6zB8xG2aeO9Og3/kAWuC2cYziv/GiYYPNeedoKLz4yLjmDHpfZ4AH/pNtb8yKFdM
         VeNcVaJ+6RcOHgfP5/8SfU8YAna3vubaT6ig/VUMpT/y7dCL7J1ErWEW4ZbcrfKYoGlr
         +PSJawdCujcz5kyOFPjL3d9Z5XWcvGFCg/88OxzWwN5gW+/6n4dnQJnQzZVYYOkbfbh1
         gjm+SwVbI/SJ86sd4S2JMJjjI8nd6zqfY6JRvsi2+dmU7KqG+NalriLBec51qAxI2pPO
         Bi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723031521; x=1723636321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9r0PfsFmuHqo6aX99isTmX4uf0XE2oPjBUWCfq0gn8=;
        b=aydT8F/NRhc6YX8uiRuNteekhSGYzdZ3+1lHnAzYckq8GbFQhUvPWRkz4VEY5A+Vdv
         PWXi8e4GKiCc5FAjO3Do9WUExT63bLUgcs2moxD1I2mTEQitOKP7xnGEXQNaZO+nE9ks
         83yIk4f6XIYyE6tLnF8ycH8mSQR424YLiHljYlYDxjbQDCiqCNVl50gSTKep5kr3ugo/
         yVmtzo++JwRsU1C9fRT0uQssqL+99pp01poWJFzYwy97nbrHigR9yNWPHuNE+9K2jqqz
         ORL1WpTkrbHHJ/Xfe9O/BcjFzoeUADslZleEDy3nOwo4nWFfLCKgJc+QQvbAkMRYVNBq
         A/Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUl+oAg7TirL+g0gIXVL6DuCCnW2Hzeet2xFjPwrzBtnmujlcJcYDmIgtqBHk0lT+Q6782Ul3sB+BNAAycK61aGsAJblI6/k4shWEFwXbhJEe2P
X-Gm-Message-State: AOJu0YwzXbgZJ28x3gJVDdrB4PjEgweswgIro0rLatLFOnvUH9dMhwuI
	oeKR5B7QW2tG0z+1Iyi3LR2VC3P3mXIv9uKqvnfywmsp2NBNRHo1VUPruL/QtzI=
X-Google-Smtp-Source: AGHT+IHWSDEf31uXc/bs5F6kU65TbGSZ8HgQ//jzi/zfHpGdt/is5ROl4riItt5O/Lw99GECzs8gug==
X-Received: by 2002:aa7:d694:0:b0:5af:758a:693b with SMTP id 4fb4d7f45d1cf-5b7f3503ec1mr15871578a12.4.1723031520736;
        Wed, 07 Aug 2024 04:52:00 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6af119b00710ea47398d5cfcf.dip0.t-ipconnect.de. [2003:f6:af11:9b00:710e:a473:98d5:cfcf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ba3acc257asm5207141a12.51.2024.08.07.04.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 04:52:00 -0700 (PDT)
From: Mathias Krause <minipli@grsecurity.net>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathias Krause <minipli@grsecurity.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] tracefs: inode alloc/free related fixes
Date: Wed,  7 Aug 2024 13:51:37 +0200
Message-ID: <20240807115143.45927-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Steven,

We ran into yet another tracefs related bug but, fortunately, were able
to root cause it ourselves.

The problem only occurs when CONFIG_RANDSTRUCT is enabled and one gets
(un)lucky to hit a random seed that'll overlay the 'rcu' member of the
union with a list_head in 'vfs_inode' -- quite unlikely but, apparently,
we're exceptional "lucky" with our testing ;)

The first patch is more of an API correctness fix, to bring the tracefs
inode cache in line with all the other filesystems. The second patch
actually fixes the bug, which, I think, may also be the cause for what
Ilkka is seeing[1].

Please apply!

Thanks,
Mathias

[1] https://lore.kernel.org/all/CAE4VaREzY+a2PvQJYJbfh8DwB4OP7kucZG-e28H22xyWob1w_A@mail.gmail.com/

Mathias Krause (2):
  tracefs: Fix inode allocation
  tracefs: Don't overlay 'struct inode'

 fs/tracefs/inode.c    | 2 +-
 fs/tracefs/internal.h | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.43.0

