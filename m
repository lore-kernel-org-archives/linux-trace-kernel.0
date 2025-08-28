Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1582A2FD1C2;
	Thu, 28 Aug 2025 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366510; cv=none; b=FTiQ/zIoxbFDMeD/5rgw8yO/AkQYOCKog6E3dDczuih30Vcxk0t37Oeo19XDUQBko8K9uGHCTzzVZMmDAZZmolbnXRCPDMgnwO+kZyz5BzKoTFt715EL6zjmA4CV79xKH9Zo1KuixiJhzJEAyQ+sN7qEVsfz+7+ZvAhY4Dj7Ido=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366510; c=relaxed/simple;
	bh=8M2/0UwLcXRxMD4ixlU21GMSrgoCNNEd15QxD/byhss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCqoC+f/n3c8jb7TDrHyyfiNSYZAo+x/DyoSrtwhGATIlBCGnkugwMp/QxQEKMQ22/WijPCzwfdul5vwMsqCIYkT4ccuXwDD/8Yba6mUHRW00fTOeI1UuEgXj6ldWLPZlZtLE/6oX86WfVkeD02N6KOW8B006R8Pj+V9UkUn1ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cox9wtDn; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cox9wtDn"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-771e1e64fbbso786682b3a.3;
        Thu, 28 Aug 2025 00:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366508; x=1756971308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eP+OdhpAXeM3MeCoK1wrQ3GVDNoiOJzpSPwPKz/ThLg=;
        b=Cox9wtDne8+LjAmL8OUbPqLfknAWhTGmLu1WLIGOBCOiPt/GJputAsHABFQCwg6Rct
         1gJFAk7Qt78msPe5Hq45CfE7yEOPtVIFsm73y72Bt22p0+reQjoCl/gL0kDyA++5UE3w
         8e3p+mjIcFqhWMcsUYil1kgEt0/5NnaIouo9qFQh/uXLgrL3LBP3aVTuv8nxamZbZ+0J
         ZnYQ/7cWVXXn04O7jTrHPeRL4KcNcHL6BG+gHLu7Jjky5NadPGlSRp9r4GDvMoGgBoOd
         QtmePwMUpb9qGLOWuAC/thOPV0kDk7qj8Ifh0H0Oi/cHESBzsZd/45SrPOexWVxrtvdv
         PtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366508; x=1756971308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eP+OdhpAXeM3MeCoK1wrQ3GVDNoiOJzpSPwPKz/ThLg=;
        b=JDgB3K2p/JDM/OajNttEi65mzeHrQGKajJno1pJJAggvTJCI/7tcAcMmBy3kE46jIu
         WshBSH9VEU5APhHmT6VoLWAULShLHZjKMlLxmCcLpfNBJrQPdHUJlw8poFPd5NtRgiTM
         iqvYcsSeZxF1d8c1z0fZ/BGCvYXGTF1OK9GVNZM9ffbpWX+XQeCGiAGtjhaur7IPKiRT
         BWEYyVv/nY70Xhj4mETXGm+Vfxm5nyD3OLG0zbdLM0PwqD5b7e83o5kZOL4/L3lxa8bm
         7v7g4OrsEwnlmnw6H7PM13xjSX2A6t4wRKeaSWp7Tunm1dMxKAlb00OpON9qsZM4X1md
         fRXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCU1W+oisOIAHqtJxGKXH6zDemS/Npm8mlOMOXgzKzDTxt2aAtvJsyTrdiqCr8CT3xWclvWW4c2Z37mv96s3iESqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl1OdzSqS51ObPJ8vveq3G0zHEWQcH5VigZe1Srta/kbj8Ii0T
	UuWLeMzQTEJV9WcmZzL2YrqyNaFTHNDk/12QGjdVV4woP2wI5LYfrQme
X-Gm-Gg: ASbGncuo3bNeTR+Hxwt2D6SpY/W8M7MuQsB1W/T+X9ZaLZe4LFS5lMubr6nxPbbkvA7
	fIKvsdSxRV/iYF81glo9euJu04vDPkPnHMURFHHyb3yECVi6QjDWgOqorhLWKP9KIKdvEkfmcS7
	qYqXbZ7oteqqKJPj/TxEQYh8PDs/wMe8Z75w9Mhe3vM3Yt4lw02JfVkv527yg35VL/mDbdZVKLD
	quykz/mfLrzJDVk+sfeXYhrheDaqTjDwH6mNx+fLFqYhg27MaRrExqO3iftgfTsFW1rTUnYItA/
	0/SQKkzvvOPlKEN4v37eKD+Kb/619My7v3sur7BFw1aSz1lT3vwD0uT4R6X+KdAYjPcK/aMxCLm
	9f7BccvKqozWNlaKGFrf7mFbI4yzPt8TP2lF5ozqUVXiJUUFIvSD9QCa+yCB1
X-Google-Smtp-Source: AGHT+IG3E7HsLBsyZBtUPuuN6RttHjWI+4mOI8ICICciNWM3PhjKuCGhtkvM8/9T1iyfrPsEw+5ApQ==
X-Received: by 2002:a05:6a20:7291:b0:243:b144:adaa with SMTP id adf61e73a8af0-243b144b09emr1456023637.54.1756366508342;
        Thu, 28 Aug 2025 00:35:08 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afb7bsm13182613a12.16.2025.08.28.00.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:35:07 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 17/17] MAINTAINERS: add entry for KStackWatch (Kernel Stack Watch)
Date: Thu, 28 Aug 2025 15:32:50 +0800
Message-ID: <20250828073311.1116593-18-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828073311.1116593-1-wangjinchao600@gmail.com>
References: <20250828073311.1116593-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Jinchao Wang as the maintainer for KStackWatch, including its kernel
module and test script.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fed6cd812d79..097a0462e604 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13354,6 +13354,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
 F:	Documentation/dev-tools/kselftest*
 F:	tools/testing/selftests/
 
+KERNEL STACK WATCH
+M:	Jinchao Wang <wangjinchao600@gmail.com>
+S:	Maintained
+F:	mm/kstackwatch/
+F:	tools/kstackwatch/
+
 KERNEL SMB3 SERVER (KSMBD)
 M:	Namjae Jeon <linkinjeon@kernel.org>
 M:	Namjae Jeon <linkinjeon@samba.org>
-- 
2.43.0

