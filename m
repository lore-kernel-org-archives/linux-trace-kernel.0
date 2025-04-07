Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEDD21D5AF;
	Mon,  7 Apr 2025 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049348; cv=none; b=jhFa6qUdHrdNsH++DvclOSR9HfIsRXrInLmU2EnWOcyCZwLvaUNNHtqQA1ouhlq7jopZhuqSrGtzsCAA7Ue4hk5+kv6nbi3fbOWk1qqmCbxpkqiIE43KyeCwuWnsHn8b66MZGWN/orJN0ayywgjtQESniXgwnV0eriVffd7kL7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049348; c=relaxed/simple;
	bh=vkdSGG1bHOqDDzpPpSuU9cSraWNrCoVM/uSZFmON9C4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j+6Qkio2xb7DGDJISr/UVW1A6r9pPMYE1MeF7wQ8Eax7SwTmiXd5q9zh9+EJXp/oRL8hcoUReQdrRtkpajfFmngBoGRFXHQW+twmrkXCu72q8n4Nvq+tc7p9vIs0teuC5VYKw4+8887rhptuFBQiHHNexYDWQIvyj+G9Y0pGTkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew7PUWkt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew7PUWkt"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22435603572so44176585ad.1;
        Mon, 07 Apr 2025 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049347; x=1744654147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sO5QthxwGi/gITP2al2MfjRxPqfuU0a+mulRSQDMGlk=;
        b=Ew7PUWkt+Mxq7wG45zpJUDbjySs06aWY9QKTI2VNuImqHbEcvLkwNEqu/Fh4HDyaKs
         TtQsObkN5fZmtgDj9dxPWTmmOFVIok08uhQTkn/P+Ol6wPCTVFQYQNxxRbEBRZ/6m6oy
         2Gx9iaDL4ESpB8sf+33JpP/7CqFjRlIvZOYp/zU+f1RmQBj6kFaWX3vAqNIkGVyIK4RI
         LGRBUsspP8tERGTKpxFqVAzKnWJFjT03qopNcwqGvotWt69gCKPRrqfzBj6sup7VrtUc
         xOINFe53jPOJ/VhXqyhCMR7Rt06PqtPKdoBEmuGMfj0jUROgDoprXtLNueGmiQ41yTD6
         Wzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049347; x=1744654147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sO5QthxwGi/gITP2al2MfjRxPqfuU0a+mulRSQDMGlk=;
        b=WtXUORuZ1ptdbyzbXCANdRpzh1yNdt75BMNjXj7BBmBuqltCPEwcoJ272jo0+lCzmz
         gRRAn7HxzGXgzXreevF6xQ5c7/FOB3yzbFrZ2u4XUAMp32qiR8imIsD+xgHsCWEkNJBl
         7lQF71GMzHMWxaPKEw11InTofupTMTZbVP0ASiB09D19jEMQlJ8UbpMvGdMp/qikOkrH
         W7yKxNaBSegnduTQ+TD/ANSFuCyQfOXu7D2pkA1wYqd/18zcnvQpvLVz70bwKcNCC2oq
         dyeUWBr2+6Ve/8EEE9GzQTavBU86CW+QOnilbeUZcMOHnMwpHeDBjeVnrJyPkJz+PVJm
         O61Q==
X-Forwarded-Encrypted: i=1; AJvYcCUS5B8w8Q2IZq3IFB132lu1s3RaVKn6DOnTdplv4mnDmbJh4oEidFxchO+craDDIyJJmujumv/ECENljVA=@vger.kernel.org, AJvYcCWzd4zMf7P70bmQULfmK6Gl1HMkJnrX7fz0noOAPYMR/OwfeGOWDsvfWXxv7TGRBc/xhE8shKG67i2UdDV12YnoKf7a@vger.kernel.org
X-Gm-Message-State: AOJu0YwebN5B/Zf/B0KyP+zFrwXLU9Pq08P/Qo2Qe5wzkwAH0z7px97y
	aa/toB4sJqD5biCxP3JOOoy+/orUKQUNMUHOXJ9jhV5LZQjW+lgI
X-Gm-Gg: ASbGncto3rLQ2ykFETVtKpIuZjT4kG08/gDZOKfny6l4Z7BmVBfP5o2TtJFjAFRn1Qc
	ogGxgHdb8dno0T186XZ3BbI4kQyH0FmOy6TSXsXaAKEvHjBA9a6BbxvLzhCLN8haGNUAuYVGCum
	Zx2t7aPX+xeGiZ2EUuG8cAdCnMHn278j8hZs2+wkYeo2j7QiodYGpRQJ+Bs78pI5ugU5FWw8aB2
	Y0qQBbebwdBIXXTDY595M0lSXBfck0TMydwLlPqcpXan6Uyjmt2C7NVYT9oaHMssq09AvoxXM+s
	kcMTs/cnNY8850bg1aGBLFLJQrMF4XtL1uoWr47AR0/+1sG8mjcQHPkhBICbpLn57SvAMqmmJih
	GLPDkiXHGZaNL3esEdjq8fTAPm4YhSyRWsg==
X-Google-Smtp-Source: AGHT+IEQoZKg5b+MyAfF5MYRIteTGVeC6PLB8bj9Qd+rDjzyW2lPRPeTqlPF4OleAXMNaZHG2RYIiw==
X-Received: by 2002:a17:903:283:b0:21f:1549:a563 with SMTP id d9443c01a7336-22a8a858f64mr170136425ad.2.1744049346653;
        Mon, 07 Apr 2025 11:09:06 -0700 (PDT)
Received: from localhost.localdomain (118-160-134-247.dynamic-ip.hinet.net. [118.160.134.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865e03esm84282455ad.146.2025.04.07.11.09.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Apr 2025 11:09:06 -0700 (PDT)
From: Andy Chiu <andybnac@gmail.com>
To: linux-riscv@lists.infradead.org,
	alexghiti@rivosinc.com,
	palmer@dabbelt.com
Cc: Andy Chiu <andybnac@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	bjorn@rivosinc.com,
	puranjay12@gmail.com,
	paul.walmsley@sifive.com,
	greentime.hu@sifive.com,
	nick.hu@sifive.com,
	nylon.chen@sifive.com,
	eric.lin@sifive.com,
	vicent.chen@sifive.com,
	zong.li@sifive.com,
	yongxuan.wang@sifive.com,
	samuel.holland@sifive.com,
	olivia.chu@sifive.com,
	c2232430@gmail.com
Subject: [PATCH v4 04/12] kernel: ftrace: export ftrace_sync_ipi
Date: Tue,  8 Apr 2025 02:08:28 +0800
Message-Id: <20250407180838.42877-4-andybnac@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20250407180838.42877-1-andybnac@gmail.com>
References: <20250407180838.42877-1-andybnac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following ftrace patch for riscv uses a data store to update ftrace
function. Therefore, a romote fence is required to order it against
function_trace_op updates. The mechanism is similar to the fence between
function_trace_op and update_ftrace_func in the generic ftrace, so we
leverage the same ftrace_sync_ipi function.

Signed-off-by: Andy Chiu <andybnac@gmail.com>
---
 include/linux/ftrace.h | 1 +
 kernel/trace/ftrace.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index fbabc3d848b3..0d4eec574707 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -807,6 +807,7 @@ extern void ftrace_call(void);
 extern void ftrace_regs_call(void);
 extern void mcount_call(void);
 
+void ftrace_sync_ipi(void *data);
 void ftrace_modify_all_code(int command);
 
 #ifndef FTRACE_ADDR
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ee662f380b61..d06bd4a046de 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -188,7 +188,7 @@ static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
 	op->saved_func(ip, parent_ip, op, fregs);
 }
 
-static void ftrace_sync_ipi(void *data)
+void ftrace_sync_ipi(void *data)
 {
 	/* Probably not needed, but do it anyway */
 	smp_rmb();
-- 
2.39.3 (Apple Git-145)

