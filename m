Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89303DEFE2
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392915; cv=none; b=tLJbS3v/A8znu4FUz/wsBZwnMuYC77Ho5tsh/vA+baSziSMwLnfQYvqzXUGDQrCM9XI7vgj3SetfbwuD6Yr/GYhiJElNeos8UWjnaaGPekmJYK19J7qpBUs/OAhQxjlXhgKYOS2Jnp8LBU+x/pae7Tpu+2UrUuTxGmn7T4IYYTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392915; c=relaxed/simple;
	bh=Ci44wgDN0GN7PC0pFLwh2qIUZhXRf/cUbP346xyKCR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwhA55T6/LAKlBS2OLXILfdU0aZaVoP8KmsZDkepxuZbgXMwsn7dhrqqZ1zo7kfOtskYF2Gd25YTmRC+PUFQvXF9HGoH/s2ExaSmB4QQWJaKtsbSEWCSC0wxK2wcJQGnE/9tIlnUWx0TkRF8TPAZOjL5rXwiHMoIx1jx74GdZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSaJojxc; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSaJojxc"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ef15d3so281864666b.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 06:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789392910; x=1789997710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MNT4kKLCYJ3hMXnGWz3Nru1slAulvkgUfWcgV9YmQ6k=;
        b=nSaJojxcV7zQVAi4KU0Fvywgvo5pXnSLEpW2UE0hsSDE6RYr3DVxO5ZFjKbp978nC+
         xsu9G/vkSGKI1THdlz0t5xTDCJJ81sTEtWVMnC9lP1EJO5bQY7ZTof7nBVadKPQVJpmX
         Gxu+fI8CjNfDziuHiyZdPRkswguOYqeKxPYTMTLQVQsbQu5W261d6aoYE5W4CBkHTp5I
         FtpfiM4Gh0Lk13mkdw0RDu9CVW6M2kDP7FuazCGBywznebtLQpBjz4rY0E6THwpJu7RN
         a67qo7DEPtPsT9f4IdgPR8j8Rz0xnmDvCTxOY3Q1fs/lcuwc4uiFYnmG7Xrds5ToINNh
         M/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789392910; x=1789997710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MNT4kKLCYJ3hMXnGWz3Nru1slAulvkgUfWcgV9YmQ6k=;
        b=Xcj5oo5BOgVuK1cuBfEAsaSXlwdB7e+EzqMGSrPGIYyT3Nmnv/UqaTiS9rkmKqC8TZ
         q/6F3YbQis6FnMvAyb7zPbSny6kCyaJwDRW20x+GZTezUcYhSoLLFm/LIumpOJNzcT46
         xsdFWywBqq/SWNBw3pjax3JqgbxSNo5ui3eb/UZTSw9Jvzx/G3sK8L4XyA57jSde5M0y
         k9GAdirY2CDsxpWzB+YtUU2thXjmBCxpFXEqMiqFElnrxCurxLwtOgRA68z3Vcb5cY50
         a9IM6Kp0HQlDwCsDI5LuMbpOVyXYU1Z0+ifnYzMFJw9PYca5j/7UXigFLSnJmXl30EEo
         CI9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzngzocTt5znTLUeK7LJ9m+x2ZmXSbo0jmqaEwF7YVPXc8xB+zcM+HqnadvUFhWplFRwU5POo1E7sOj7OHSR0KxgjQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lz6kuDg8FRQFl1Afs9Sz/DOg903KcmwSNMqA6AM6Ib134MNDvC
	BByw0OB/o5oP+9XkdW58uO6j3gLnKh56Vn84sm2N5CrIF4iUGweJEQDD
X-Gm-Gg: AYBFou0qoFf4ZXlJEHyo1W20iIQm/Tbg7xx6GChFqM3k+AZn1EOcF/JUla9xBY1yapE
	xYUI8QJH5r3uB4GXilvxtVIk4NSf1d7WL0VaA6qd7+kWZmMpUaQBRxQSnXwNqfk0bpaUs8ESYo6
	+Kqjxw/dNnMIOQqJTLx26jlpa1kp3VJmYGTAAQ9oXyGfczm/3pWGkamcLR0OiNG19HYsLklaCrC
	7ymE0hadIqrLuqPDis/tIXXNv5eZio8hxm+UUMsEaVHN6uIHnXJQqm1QHry3EpoYy/2d/JZkteA
	CIY+kbE6masOyf91CSG2PFAUcF21PZg9HuzJPSH8U1PS1nFwdE8da7xpyf4aIslCGmHcw1whl0W
	tPC0SSFgkWuNv1nWb1GewU7yjkncWg+WvFrt86fZpw6CeE+oOn0dc9Xr1sdvzK++oltKOvPns0t
	vAafo0hHg/V5sQ6kzb6woOgsXucWNDgRT75vIJPZH20+XE2T0Y56gGP8xmg4nMEjo335Dsbs30b
	Orc3be2MpPZYYqE/Fpml2ALyZOWUzNq1p+mDHRG4rtZcFCLVJHT7WXWCOI=
X-Received: by 2002:a17:907:7204:b0:c16:84dc:9607 with SMTP id a640c23a62f3a-c29b86f1119mr352247966b.19.1789392910285;
        Mon, 14 Sep 2026 06:35:10 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2966159c07sm441454566b.63.2026.09.14.06.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:35:09 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2 1/2] tracing: Take trace_types_lock when dropping the buffer_meta reference
Date: Mon, 14 Sep 2026 14:35:04 +0100
Message-ID: <20260914133506.4865-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914133506.4865-1-devnexen@gmail.com>
References: <20260914133506.4865-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tracing_buffer_meta_open() drops the trace_array reference with
__trace_array_put() when ring_buffer_meta_seq_init() fails, without
holding trace_types_lock. Use trace_array_put() like every other open
error path.

Fixes: 950032ffcee7 ("ring-buffer: Add output of ring buffer meta page")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8658cad53cb5..c8295324ffaa 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5881,7 +5881,7 @@ static int tracing_buffer_meta_open(struct inode *inode, struct file *filp)
 
 	ret = ring_buffer_meta_seq_init(filp, tr->array_buffer.buffer, cpu);
 	if (ret < 0)
-		__trace_array_put(tr);
+		trace_array_put(tr);
 	return ret;
 }
 
-- 
2.55.0

