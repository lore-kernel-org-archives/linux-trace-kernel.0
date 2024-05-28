Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C673E567D;
	Tue, 28 May 2024 00:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716857537; cv=none; b=V14CsFVqId/FTAh2yxVDQQFDmtrQv/zopHtMg6VAnmz4l2ClMrcX5tIHP0BQHLflKrc7aNb6eLBcWItbNcZSI4IvmGR1JyT/5SqwIcl5WdC5Hu6Qep/uqGeSOAdDkxUtolWeaAZjfyWEKFwGJGOhtroTgZHQFC+6YC0vAN7rjYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716857537; c=relaxed/simple;
	bh=9+qOsB9FSNnYMqlHWCWdG4w7SSawX6wzhQpUTixM48c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QArYZ+X0Csu3ZbGTXlFqTIGZHzt1BusllswUx7LJrSB8C7Bmgyk6uu83r3vXAhZn9AXG0mgfW/q+M6ZCqonz1ybn8yantRFVkB4wQE5vYxfViilaaWJwt/lIg/1kg/ia4Cf5gqxonmkXuEnyzl10OK0fzchgaJa+6RUwQMOzMeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jY1WPWFT; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY1WPWFT"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f8edff35a0so203117b3a.2;
        Mon, 27 May 2024 17:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716857535; x=1717462335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xKtUwdzLUJXl8/4cripzbl/ic6G89sQMgX/ixX4R4Js=;
        b=jY1WPWFTBqfNEY05HR6thIXHSdRjfxS+tAJBn3dKeX/BH8K2HnZYdm5VjoIZqEXK2+
         mY/1N9L5EZEsXm7lCCJFSFHjlEPvpkLfj+sFDfV+e19FNvEIJL7AiAQO+Hito39+3qmI
         S7VWwaM0+uuuYzXnOd9umQGvBgeXCuk1jAKtuUsHLcHerFXVfHeA2eM5o8nXaxmUln6F
         Gm8btTnM/as1v39T9o3fB8pEH2pmSSHpFvJks0p2pX40+jUEQlThih0vUhkLhaTHckmV
         59zgQW1sDb7H1RsXvdq09KEr+Yp4JwhnHj6TpUh3LdHmtAD+cF7y/X3+rfV30PyuwJQW
         Db6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716857535; x=1717462335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKtUwdzLUJXl8/4cripzbl/ic6G89sQMgX/ixX4R4Js=;
        b=bBIzfk4GZM38hjr1Xb4XfZfdTr9HJBWUoO6LqT9mp8lkjqi2F3z7Eff7AwEQ1MNewu
         cAEWj8LkuPfThAR2OsAIJ0JxptXmKg44rtzTB/s/ilgcFfqSQKHp7Lqp+XRO+LTtxUF7
         PEpl3mCRPWFyo25PWDCgXezBZpydjeOtgaNoEMLYss6IUC3Lq19bMfjgTLaO1e8Q4NxA
         iyLJHM26++5RHGSfEVDDwiMfZIOMhZw89QPF9VqKy6MyosdQrZY03nEdSUcnhEqKM9vn
         tcJ/HszU2w4B23vaHb1jF3lnNK15hIXd8/EchQMLFoEsLsIalbuXd7OjpDJUuz//Zix6
         q/Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXWdkLG5XaZeOj//0dSUd8vsBX78+PKL2pky/GArKgValQr84cYl6TQbAY2sBGKhnb/scjKGeknhd/hBBOK7OYTRCLPiPsF7GAnISFdZn/ixMTlQLGIY4+xJvdGYVfMRDbKmz2WJze2iWlNvGqsQvJg
X-Gm-Message-State: AOJu0YygCwYtS9BbCx/pnrP0uiPdfBQ7KXTuYisDeUitByfuTqMsFfYv
	cMjTSzcxrXMpcd3oO0xX9CIXi5qLE+FtPHgmZY6eGN6SR938Bq6e
X-Google-Smtp-Source: AGHT+IE4E7rd5wzO8Nd1wpUKWwCoxuJHSFGEyVVAh+SKJOMa1mdo0uTscwPpsuXucDX/Z+DNaqACQA==
X-Received: by 2002:a05:6a00:f09:b0:6ed:41f3:cd06 with SMTP id d2e1a72fcca58-6f8f2a49069mr9672232b3a.7.1716857535009;
        Mon, 27 May 2024 17:52:15 -0700 (PDT)
Received: from mari.. ([2804:431:cfd2:68a4:aa72:2951:3a48:ba9b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcfe64e0sm5401775b3a.160.2024.05.27.17.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 17:52:14 -0700 (PDT)
From: MarileneGarcia <marilene.agarcia@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: MarileneGarcia <marilene.agarcia@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ftrace: adding the missing parameter descriptions of unregister_ftrace_direct
Date: Mon, 27 May 2024 21:50:46 -0300
Message-Id: <20240528005046.3778431-1-marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding the description of the parameters addr and free_filters
of the function unregister_ftrace_direct.

Signed-off-by: MarileneGarcia <marilene.agarcia@gmail.com>
---
Hello, 
These changes fix the following compiler warnings of the function
unregister_ftrace_direct.

The warnings happen using GCC compiler, enabling the ftrace related 
configs and using the command 'make W=1'.

kernel/trace/ftrace.c:5489: warning: Function parameter or struct member
'addr' not described in 'unregister_ftrace_direct'

kernel/trace/ftrace.c:5489: warning: Function parameter or struct member 
'free_filters' not described in 'unregister_ftrace_direct'

 kernel/trace/ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 65208d3b5ed9..6062e4ce1957 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5475,6 +5475,8 @@ EXPORT_SYMBOL_GPL(register_ftrace_direct);
  * unregister_ftrace_direct - Remove calls to custom trampoline
  * previously registered by register_ftrace_direct for @ops object.
  * @ops: The address of the struct ftrace_ops object
+ * @addr: The address of the trampoline to call at @ops functions
+ * @free_filters: non zero to remove all filters for the ftrace_ops
  *
  * This is used to remove a direct calls to @addr from the nop locations
  * of the functions registered in @ops (with by ftrace_set_filter_ip
-- 
2.34.1

