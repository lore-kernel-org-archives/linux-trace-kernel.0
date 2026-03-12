Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480B73A6F0F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773342707; cv=none; b=PGAIHMszdYsEJigFK4kJMP0e81ZuB5t/wrSmRg2sfHdr1zNgIhVVyebF0Y+91mKpFYvD4Du+OP5oA+CY4S3T/L0I23v2zETeO7LRxy3D218pLrv9mvnTNP0rKQ/PAG28oL+8YE8yxvKnWIlNSyaJXfAkkN7xlU4unG0ni3b5m/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773342707; c=relaxed/simple;
	bh=IUZsoLobE2uF0w1ny+FulSFJT4uRhc7cC9eEAZw+JIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l0Z4IZjZUxUi5spIZYODnn1+77CseNQrcgNOdmZRX0ley82qeMDx0TbRsxh9GvgArYJdp4BjHVSIZBlnFTpqPoo1GYAK3+VqR6TrpGbVFzYXYYfer32ed/OgHGA4jt9iuFZ6x2FhoslyXxof4zSt0S7BhWpU8I8UB0o6+v2vKBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjDc56rn; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjDc56rn"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a12cd0bd79so1709775e87.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 12:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773342704; x=1773947504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U13NRk7kD3FS9KsOKZYfld4V2BNRCS2wvY+Eqn6qEX0=;
        b=JjDc56rnJiNyTYGc864nU/q2SjlBruJ9jTnhQWv+qyI2WXZJEZODVQ7AjvnbnQCwqG
         K+XPa8wCI4yT0wmyQgvdlkdcwzT26SumMyasJvIEUc9O+VNEmqAhwSeSQea8O1CKYIzh
         IeSbjp0RM4G+RJB04O0BBV3WDRHECiaHBKMZu995nJ+5K2ESSRHvNrLxj/3iiM451L1f
         vhNEMkSEOW/VqkXKQwAW1GK8Ny7b9XwUXchivRIvp6dEh94Xy8q19jhea/2odrH0FrWK
         c7HsWH4p09nzcDH1A+NqmM/G3IL3aiCtIRsqIGZmiaPO6VEkOVTPcpTgUxwetathFcyu
         SDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773342704; x=1773947504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U13NRk7kD3FS9KsOKZYfld4V2BNRCS2wvY+Eqn6qEX0=;
        b=nEZ3yQuIZi6auCf71bXJ6zrcHze0N9TmjBzcr/QlJuXqYQPJCTti8RK9blWIo5DJJE
         15wzf8QELygBDdi094kF+HKEDjya8OOnsuVYHXTBSDguagbzK6AnUx7UJaENDIzXkDRx
         bdv2VQCwsFaWZjP+26GNfkIBSR8qOEa0PMKcL86Wre3YPbAtURSCPPsFhK4gdnNH5Ci6
         4dTGaX3cLehxzno3wXAt5eo3Tpn7OnMj0hS1gzgbzF5DjgUT5bW5L0Sanff2taNufTCD
         tapVEaykORwBMQ9KzgoN+mOe8NMUCLmzS4KLT7d7gPX8Fudnj6nAYnikA/1wUZkTBjMT
         SHUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8ULtIfxV02HA3dolII/bfzjjqwj+oPmlsKptDKiQYOnh59lFScLA/ij4IoNzOBw9sFY7qWg8aQpgUF1ahZYm1gtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIgAq3LyjosVLz2zOXcoD7ALuJx5598e4RDeyTbnTX/xzssc2y
	J1b1xMNTwcO+TY9oq/TtJX97/OMy34+Zvj2okFVNMDM0apEqA/OAjoit
X-Gm-Gg: ATEYQzw21rB+7CgkqLl1O06y2yjK8VFUr1R5BNasm037kaoLtNhNcuVGkQ5he5GIb59
	PReHu6rly15Ckx5sz2nUTRvcUwqL6l8LdSci2MpSzee6rqHLdl0yjyy0Z7fd6NOSR2n6+BbPUf3
	mIOGGxbWT6pyJsJruRwUCT2J3IpghYb35xMvBGTdQ+HxbjtdHRpma8m7S2fRD+PZcPy1XU4OVdc
	JxphKU9dFgkJaId6uGdr1uNPJ1EQd1UXojdAFZ2HwUifLq3b0l8VTadCxEW9wNb8cimLwxLzyH3
	haPKjddIcOxb2/AHn/adDrRGRxoHvNeVTAT1Fg0uAX/h7Se6WQYw0p8lG+ht6EEwE8WiG8PtDdy
	kEP6x/TXTZBDmnGiJ5Qp2sROiIuUYdGq8wnnEjpAMuqgTY4CfGNIL63X6YMljB6Epfu/kBW64ZD
	qNEHenkg2lN3D6EmpUvF1AE/PTAAeY8mFQEIPt0STr56vsnim14oDh0LkX2UFadOoVljnoMBZDX
	ArhOZTPsg==
X-Received: by 2002:ac2:4244:0:b0:5a1:2e14:134c with SMTP id 2adb3069b0e04-5a162aea27fmr128006e87.5.1773342704136;
        Thu, 12 Mar 2026 12:11:44 -0700 (PDT)
Received: from ubuntu.. (static.159.107.27.37.clients.your-server.de. [37.27.107.159])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156375198sm1112249e87.88.2026.03.12.12.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:11:43 -0700 (PDT)
From: Josh Law <hlcj1234567@gmail.com>
X-Google-Original-From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Josh Law <objecting@objecting.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] lib/bootconfig: three bug fixes
Date: Thu, 12 Mar 2026 19:11:40 +0000
Message-Id: <20260312191143.28719-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three fixes for lib/bootconfig.c:

1. Fix off-by-one in xbc_verify_tree() unclosed brace error reporting.
2. Check bounds before writing in __xbc_open_brace() to prevent
   potential out-of-bounds writes.
3. Fix snprintf truncation check in xbc_node_compose_key_after().

Changes since v1:
- Added explicit From: lines at top of changelog.

Josh Law (3):
  lib/bootconfig: fix off-by-one in xbc_verify_tree() unclosed brace
    error
  lib/bootconfig: check bounds before writing in __xbc_open_brace()
  lib/bootconfig: fix snprintf truncation check in
    xbc_node_compose_key_after()

 lib/bootconfig.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1

