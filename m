Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3E525BEF3;
	Mon, 14 Jul 2025 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509371; cv=none; b=eJnJXBaY2HS+Ex0U3WOnO6xKFEP7KDsfwdlMR7rNZlkW4WQN9tTDdQJO9SXmRMpzGkI7rs8Z49NsDQu3feDGnQTBy69meye591tCWIAHaSXFdGvZSoihHKEI62tvoWpc/+CC6kBwmXa4TIck/Abl6ryy8NNIxOHwklrewTeHEEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509371; c=relaxed/simple;
	bh=z0tuuVyIJcpo1TwGgRrUNAHG4ncruay5NpOEMetri6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dnV7Z+MGCZjr87o7047KBM+BwtBaxi9ac/eSrTqePUp4XptCB7eHiI3bt1FLa011XoWSIlScG5ALFiY/NvQrU58COdO6pNr4C3E+GCoFLlfEqY0m6s7YZ9c8b7EF7ehEvHWR+lrn/JrohlXy51rspvbn8tLvh4aDN2iIDUMQRJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwBqbJvG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwBqbJvG"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a54700a46eso2748528f8f.1;
        Mon, 14 Jul 2025 09:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752509368; x=1753114168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SSzZ8p6ICs4tmD0sDNFJUVt4Z8VQSMvhy1W9WuQOiZs=;
        b=bwBqbJvGCNprL4502uUTcn6W2KUVrPnsuGfXsjHXr3R9eiaBb3cYReFzoSd2ol8Cn1
         a6y9VEwvzOLkEca2GuUB84CQF3JR5PA2DCNty0PlYIniRAlo6VFQzvLwSBGncDuiQ8va
         /zBRT8OIGuCmqA/P1oOps19w+MbOqYuQ9V5dn9RK5ssU3pZmPMWiCRhxCXbQ3xG/nLdx
         1SftjyXnA5hpunsPrpHMnp9hKAWZYcdveKDkS9mdlctTk4A5lCff0iefJvUGUoyVlcum
         0Cfb+iWGeLO9oa6C1zQIK2n2jHNNduQSEbkPyh6pYn2o8pcHOFLr1rqUkMisT0fb1H64
         PUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509368; x=1753114168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSzZ8p6ICs4tmD0sDNFJUVt4Z8VQSMvhy1W9WuQOiZs=;
        b=XLQzRh2QU4YK5z/zRDeoWFsTwqCuD0HlnHYxC5RIH2+7qll5LmbmQUQr/4Xzk9IWmA
         1N5Hs6nknFvP8Xt2fKNC/6gDUgRRLexXdyNwdkttgTNS4WckShl/jyvxiuyGOuurkaY2
         OnTfG2pwpuT4pHeTF1Z/zxSUinU5K7HkkDYvt7w4HCLOjdbo3Bco9VqUACN27Wgs/8wE
         b4mkyFMO/E4d5mOxt35Rbl6qhuBo8OsVzjbKt54VVHfaMHgFGJaJLtR8hnMqyb2qkNWY
         uJfBtm76J6h+W+osFOkdHZDzoy/qQ1aX6lH845ewD5qHPD72NrfH0RsmvOnw4twWfvUx
         mpEg==
X-Forwarded-Encrypted: i=1; AJvYcCUie9ZtDSuRUWSP8UE4sAdCpC/MZNb7bVWQiYvC7l7ZgKI2wfM72wOyirMlVnDq06MtoHUT4y9DPJhzesw5NY7aBFBc@vger.kernel.org, AJvYcCWsilHbBPXqxH1IwoHL50jqmkjPS8sjZRTfZo5gnRT7pV8hZdDQoJ9qgwySStAxrcw1EiQaRhcrmbD7xpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWU0po6TTqR7mZBjg7yLo8+z72to4H2jN6iIKXEbpu58Q93E0C
	ubS6NvqQrCagDrhjIrV/aEC0jMe/LbUXvhJcLD17OcNj3GLnAfwd9Elf
X-Gm-Gg: ASbGncsycYKEWND5HAAB4Mn2AmwqfpbuHyT0OO2O3h+1A7tfZP7OSLDkgGrsGFdazTR
	q7XA4kPu+4TKwzEgaH7a0VKb9IwtfZtjlo0lHlPwQM1ii2Y3nbuzqisQuix6lPPk3uWrwb9/ith
	rU+T86Zm2llvTLOn+UsDHKZdMDWu9hOeQY5CpcOaxFH+/cGzsBGJhWfQ2OaW4n0+2Q4qxnHmNQq
	LHrl26y2LNWG4Ng9mrnp5NUCtg/t2Ju0aqI/IrBFX1ebIyzvs0PnufPkrAPtyDsXuy7BhbEPCm/
	IVBaxuoITV3oYlaxJJSTRqdiMjrGJwokpPbfnsnd9K5Ev1ANvP4Vt3aT1z7jmaH8AiCJNiSMl4v
	bHBQx3dHi1achB3w65Voa
X-Google-Smtp-Source: AGHT+IHQkWwwAJlutqADGT9UHvudQZQIiRedcZ8BLQYAcJLCc07J65qfmtK2g2rT3yv0EnrvyVv/ZA==
X-Received: by 2002:a5d:5f52:0:b0:3a6:c923:bc5f with SMTP id ffacd0b85a97d-3b5f187ebaamr12549329f8f.17.1752509367510;
        Mon, 14 Jul 2025 09:09:27 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-455f222e4f4sm96666205e9.10.2025.07.14.09.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 09:09:27 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ring-buffer: make the const read-only 'type' static
Date: Mon, 14 Jul 2025 17:08:58 +0100
Message-ID: <20250714160858.1234719-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only 'type' on the stack at run time,
instead make it static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 00fc38d70e86..39aa1f50274f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4118,7 +4118,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_unlock_commit);
 
 static const char *show_irq_str(int bits)
 {
-	const char *type[] = {
+	static const char * type[] = {
 		".",	// 0
 		"s",	// 1
 		"h",	// 2
-- 
2.50.0

