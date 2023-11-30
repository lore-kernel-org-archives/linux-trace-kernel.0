Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dhoUccPU"
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8711708
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:56:10 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6cb749044a2so1421390b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701377770; x=1701982570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2mqH2Bu8VDSZQl/oVmtaFk1bQrPnLFzomfRgzjPU9ug=;
        b=dhoUccPUzLdedFmR72dBLBBf1AwWJCbZWRG/C11ZKHT5/v2loNjYwqyQHWCR/NFqzx
         rGBGX7d51mgrdd6Y3J0GDjJJkU6T6nc8sCL3krUHBrvKyMqmP0Th6gCrBljtEhaoaJyA
         rs747QpY0EkW5QjvDmo1KWIZxDlllhNBVS0qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701377770; x=1701982570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mqH2Bu8VDSZQl/oVmtaFk1bQrPnLFzomfRgzjPU9ug=;
        b=GI3CNdIu00xszeHyh5AbM+XEDUmedrJ9AWTSkXeau0x7Qjw0r3u1bLyRN6nEIdbthM
         QsZyQxDdECDqPG7R31qfFFKOYoYaRuAESsK0YqqncspoQduntfmqGVVMXnGt1x3B4cgm
         Iiy6ec2Po5gVW0WYMparn1enJYp95kZP+mMXY+PTnsZNYWBW/81qPUhBeZuL5pcliW8c
         E2Kn+IIQ5gWrPnGclZ5stC6uweNsHCf3AYSk7BfHFSkehHRXlmSXo/kJr9/LXvCKdoDn
         4yaN9IeKBvtyhV7pZ2n99N2oPYHweIEuQ4Ijcs8EhwrU3xop8TeD7OKJfuJDmO5ifKyU
         O9ug==
X-Gm-Message-State: AOJu0Yxzmf9+v+SZBoqcp5AoCkKfbQtTUJTKANrhbRAmKj/nW1yXBDWU
	zQpGuIx446Qe2uLIB0G424YfNg==
X-Google-Smtp-Source: AGHT+IF/p/yWidHm/LXNmEns/hCrvoFxobs9OIzRQhwApsdqdtIkzzRmCesyaYJ3JlISWVm6Hx6nSA==
X-Received: by 2002:a05:6a00:3907:b0:6c4:d76a:68ff with SMTP id fh7-20020a056a00390700b006c4d76a68ffmr28870071pfb.17.1701377769742;
        Thu, 30 Nov 2023 12:56:09 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r8-20020aa78b88000000b006889511ab14sm1649631pfd.37.2023.11.30.12.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:56:09 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] tracing/uprobe: Replace strlcpy() with strscpy()
Date: Thu, 30 Nov 2023 12:56:08 -0800
Message-Id: <20231130205607.work.463-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408; i=keescook@chromium.org;
 h=from:subject:message-id; bh=VAQ/FNnq8v9CzAsxQVG8VOQQl1gkuhbx7/nJ2nLij24=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlaPbn40MW2pI606YFnUzI2iau9NKfIMFA3hhNz
 i9rV8Xp0L+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWj25wAKCRCJcvTf3G3A
 JphxD/0ccMJyONx88iMeiVBBxhpQxMXLZ3/cgij/f1NWWQtky8CiRVSnmiHuwuHEGRkZvv2H9zH
 /0t6VYWUDc0KsaXIYuf2zRKW2rexz7CdRO+C/HB4EKf0u7AyY1hly2yTRFmSJfIm5iOg9oGmmVR
 ejxK8/epLSsTFuKcCcfcnSGiTrsM8zOGSAAB35wKUazI7JepId+k3bpipXDdTK01v8fpIkabwa1
 KSfC2JLVya7CdOm3kF0fNNu8GEcuYeNGLCVloi1RxLNsey1ND0XZ0wPiL3HDkSp8+Lzm9wpoXQ0
 jQrOQidOcEUCwsHvQ/xMoGzHIq5DgU5S5Xey3WFjPKyVq3EsNs6YRkN/y2AqQxc4CtJIDA7D6nv
 bZkIiEGjX2Aafqf7GYMD6bsqhdQsHccbU7/RbFc6rW2fRcmHnT6h44ht8zPAhXhx28b5+y76JaU
 mOgqxXBxGfOU2H3soJFvAcP5ESM9uT7Zlwq2HDx1RlT74wKg7S9ddsXxQBXKhcn9FopV+VKXYVD
 B+is63bPLIcijjEk0m6B5/UdHl4OwEkRABa+TUEGSBTCCXg8CZxTzOrvVtKbdK9b/R4u3LvH22M
 ZL60zhmY8Cl8gvldvxIQk2CJJRXoyJYkIKcgKDl5e6ej1i9ahR+mrgUGsovY1tzdZKz3TDrGb0p
 bjYwntr ZIx4iwLQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

strlcpy() reads the entire source buffer first. This read may exceed
the destination size limit. This is both inefficient and can lead
to linear read overflows if a source string is not NUL-terminated[1].
Additionally, it returns the size of the source string, not the
resulting size of the destination string. In an effort to remove strlcpy()
completely[2], replace strlcpy() here with strscpy().

The negative return value is already handled by this code so no new
handling is needed here.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
Link: https://github.com/KSPP/linux/issues/89 [2]
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/trace/trace_uprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 99c051de412a..a84b85d8aac1 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -151,7 +151,7 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 		return -ENOMEM;
 
 	if (addr == FETCH_TOKEN_COMM)
-		ret = strlcpy(dst, current->comm, maxlen);
+		ret = strscpy(dst, current->comm, maxlen);
 	else
 		ret = strncpy_from_user(dst, src, maxlen);
 	if (ret >= 0) {
-- 
2.34.1

