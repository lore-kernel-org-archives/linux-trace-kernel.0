Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4C33207
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764793392; cv=none; b=NyN2TbNtp4wPBtMJkh4n4VO1OxwVPpMajZwDbMUDjAFOSaKoBHNArtl1cl/Yq+rWA1bUJ977CjY/YSL256B2qwBb6oACcBvnLwavR0xuXHWK4Bqa1m7SEPdV6wfSCqwqE26KewtYA8b5t+GivDhHPYITdzfY9owtXP0O/K461qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764793392; c=relaxed/simple;
	bh=0f2cRLdtpfZ6XvzrazRLf77iCUv6pFST8p4qLMv4o/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eJiLvkD51mN28q69M02ZJSQF3B6qwcPGeer0vAwwyf1IFMeB6kOEtYyC54JVjB4oW+IBTiWFMFigT77b7OExl6/vUxT3D2M6oA5G7AY4/N83RuIi9jVnrD565QCfVl/PBz7cF4BOAbLxJp1DHn/WZycwVFlATedxaedCyKrK05I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzQAdvT6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzQAdvT6"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso105531b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 12:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764793390; x=1765398190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1l8AoDl5OxCUERbVgKYnUrs0Din3CsV82rQuW5hqhlI=;
        b=CzQAdvT6iEHePKHv4QbNGAT3fpN0IOaII168D7avh1ylSY2uyap56BBJQcWTATJF4j
         AIBoOIcRDNusUzvNck19g/bEL8Fwr0wymd5JLzj8TMVsefmxnfk/0o2vRuIcZwE7hcgx
         HUyQO3E5hl6eJXomC82lCXaZgK1o+eaHFKx7iJeGUULNxdqw00LGcD/1a1Y5+PonAY5n
         ogB5s0B3bll/aEXFsimDoBh/5uUerb7YuSdmGJfpf8D0vhmWfLbhghq3H6tdOKXowKOq
         bw2KRFsLmgafjUvdUn5vDZL/rLMwijxWr1h2+BGbnawBRWSqcUd7t1U/H6foRLfmpw6X
         Xjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764793390; x=1765398190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1l8AoDl5OxCUERbVgKYnUrs0Din3CsV82rQuW5hqhlI=;
        b=KklOTBcMPHRcic28buEwnqYTt70iFaWWqj8cHfHTDE2//y/mUGT1sN7AMhkqXaYvDv
         /iv65p4yZa/n5i2f2h5wuENZCxuWgdcVfn0C3LJz+z2flPHY8utYrlM5bpyttTLK/NHA
         NXukFMwYCH/0/Jgg6isLzMIFKktZtK1jvSAAAb6DTBk7ZIZsfxbgkPpKxl0x7RNefb53
         PSX0D5hudrNh7g5vAePxvGwIqUuNXg2PJtdqcAEKzwVkhVCnfliX101+Qx3H92wERtFe
         xQX/6biQGtt950LQSMDIEVhJeFw9YiBr+tSMyvpwu+qaHc3PIODuXANL1dOx480UBPjK
         0UJg==
X-Forwarded-Encrypted: i=1; AJvYcCWdssAC2dV3DMu6f3wfzvaj+ZgdD2U3/HqbhNvl8BuMwxZvkvDcCR2ldzOSciZDqGclm1mMxM8DE+Gukw+8zadb230=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLnqp+DXzk02WL88xEu7XxRaCVrjTYUfDTEvhW6A1q9Egup9ap
	Hv3mQIrzWqIuiX/TrCv3aU0oLxVVu3jMzzfYBTF7DBp37xLA1WFauOG9
X-Gm-Gg: ASbGnctfVwefSZVOgf3XicWYgRjf1ZALcQJfHBDUI/1CDv0LR5dJ+tZbT5yeOZ5QMAV
	oJ7h6DcuSLVXCeeOPuqScV1Ns5K3L5U6vnQYvrPObtkt9TnP1d8DPEVjKWuQsB7xARLSvbgTokT
	Xu47tuw4WRu/7vjrncbhwVASuTfua68OV+fj4Q0OiYRmNkrjX4iX+mTAnAYiNngxvTDmry0d6Cd
	1d1S97BbCIUtfgNeZSlT0IQYC2RFRsS14eDjSpqpkoGNkx5W2VXofyr5cIduANkhu9dWP1ct8TW
	VOKVsAr7A+dp0FDD5EnIB3MLay+m8Tp1bOcuo96hSH1KwnYfKyBFSYNwXQHusf0zz2KWJLm0S8P
	UIHUHO/XjKwvMzOXB8yqe8DD59yy+87w2dOkirGN/OmcE6bnnLQExnmes4yOlWQREc6OM/1Hc7Q
	0spXOrrJDb6brj24waikLb
X-Google-Smtp-Source: AGHT+IGUUL9n7DaIa1cXN6PrpkeXmukJ76Q6yRwk7pkWsuHejik88WLcCt6xCXQTWG2Rg79pZuVvbw==
X-Received: by 2002:a05:6a00:2d0b:b0:7b8:c7f7:645e with SMTP id d2e1a72fcca58-7e00dbe88a9mr4580243b3a.17.1764793389917;
        Wed, 03 Dec 2025 12:23:09 -0800 (PST)
Received: from soham-laptop.. ([2409:40c2:116e:6f1c:ab6e:2f5d:e763:cc6c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e15f4e0810sm1287230b3a.7.2025.12.03.12.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 12:23:09 -0800 (PST)
From: Soham Metha <sohammetha01@gmail.com>
To: linux-kernel-mentees@lists.linuxfoundation.org
Cc: shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Soham Metha <sohammetha01@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] rv: Fix dead link to monitor_synthesis.rst
Date: Thu,  4 Dec 2025 01:52:59 +0530
Message-Id: <20251203202259.69116-1-sohammetha01@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file 'da_monitor_synthesis.rst' was renamed to 'monitor_synthesis.rst' in
commit f40a7c060207
("Documentation/rv: Prepare monitor synthesis document for LTL inclusion").

Update the reference to point to the new filename.

Signed-off-by: Soham Metha <sohammetha01@gmail.com>
---
No functional changes.

 include/rv/da_monitor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 17fa4f6e5ea6..c2cea209f230 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -8,7 +8,7 @@
  * The dot2k tool is available at tools/verification/dot2k/
  *
  * For further information, see:
- *   Documentation/trace/rv/da_monitor_synthesis.rst
+ *   Documentation/trace/rv/monitor_synthesis.rst
  */
 
 #include <rv/automata.h>
-- 
2.34.1

