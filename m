Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D762CCA0
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Feb 2024 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765496; cv=none; b=LTGJXgqQWUBZF6SdZjrLCejuMYZF7xD+sPutMZqCjTAOlku7nfsQ1CXjEBKBYK3iFLTJQjFeP604e892aYrps2LFr3Eq5Z4YmMaVWcuvOKEkc+lFhSOYEThTslOj6qlNrAuDPpnbP+pLBZ28mh9tmE6fUx3G31xNTiHE1xDnCu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765496; c=relaxed/simple;
	bh=ONxj7Z5bQEyPpk/sK690IPfrd/nKeK9bQ4FibvhzH/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rg8cZp6qBRfhlp6NUpdKY7bBsDsgpT9oyolrRBDTNHrKs8rwligzrzsIiTw1B6S0rfjiINY8cRf+2YIoHCr3i2KpnFiiF3zPI5qb5nNEjZjygZBlj9uSfFOjpPkoTlBkc8lIS1FnuVD4icQs8CxSj/c/82qNd9vhGkjEpxkvrGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=b5O5EhPW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="b5O5EhPW"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4129e842463so814995e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1708765492; x=1709370292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfQPvdG/1knhuB2wdxd38i85RMYhhb/ulQhTX77Xabw=;
        b=b5O5EhPWnVR2ykOEHHgrIzkS5V1Hb1ov8m+Q52/l9GxGNsmJtCRf+OLbnTnVUcnjQi
         pNBPOBlDXd5rLeGJ1qfwE9K/47IsQPJ3gGlJgG+EAB7OAXHyB+l+pSUJCNKY13wOKwQj
         8wwPuiMqkaWsdiEsG5g0mxWTBvgzItSNXpcHjA0cahQvc7y2Ic9EDCOazDXJ+axfEsFj
         iUKmHijJ/hTGm99RpDMZI9KQKNOZb7iZxF00h1ztBJvgKQazM8AQ2OqwRpacjOA879qE
         8y9rDtlmavThdfEnisdz3uMMrocE48fJGzdLyQuCGw29CB5kdrzoiQ/Ax8beHMGQybbb
         LEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708765492; x=1709370292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfQPvdG/1knhuB2wdxd38i85RMYhhb/ulQhTX77Xabw=;
        b=ZKo9DkV5H/z4K0RHBmjdzWHDthG13jePjt3K3mh3BM/4qRnFqIotbBeG1KPFAOIMKM
         A49CDJqkWYzRVFHwFQ7ioQHP2z749l6Eoex9v9g0q+UExGmMcMHu8b7NzMWZZ0gnMDI6
         u/xBoRuQCj2a/3VKlnIz5L08gyQt2hxFK6Ho85YiU0PTzPrJWPgpjYDkmc0/WYh3URBa
         z/BSWPQckh5HIt+iS7ombmFz1xr6Z7tN0lTfhfnB+Fg/CbM0ibEt0fBL61g0egbfquWb
         LTBCpVhFhYVyrE6WpAmnS31uepDJxUa05LpIwr0coF7U5E9emt5ADzOrUYvTU77zgZSu
         bUtw==
X-Forwarded-Encrypted: i=1; AJvYcCUKCioamEmHJiLnAQo+xFRj0BKVwv+hhSjyOo50PNYBWBIXwq+9FSWePNAn6k2wrJLv+nD2AfX0ZKTZhZByZAe0RN+2xvXusWXJiQwQQiPIxoEO
X-Gm-Message-State: AOJu0YytZsPwTxqoAtO2YnO1xFEcHxkNQ8ydilFA2D7wHao2O1KPob/t
	JkH3//zz/jLDn+Mis6s39x6Lx0XTWX4Ldyn3xOdTSxrvY7+C7gG68cXmXPtchg==
X-Google-Smtp-Source: AGHT+IFSkxATvfxvoXpDJxSlMvUknkklMdh5OB6Hod5HFKIXcAkHG5kSo9ueF/pxNq6xZIhvsXOYyg==
X-Received: by 2002:a05:600c:1d9c:b0:412:99a9:efa3 with SMTP id p28-20020a05600c1d9c00b0041299a9efa3mr1038094wms.2.1708765492693;
        Sat, 24 Feb 2024 01:04:52 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b00410bca333b7sm5320593wmc.27.2024.02.24.01.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 01:04:51 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dmitry Safonov <dima@arista.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	"Nassiri, Mohammad" <mnassiri@ciena.com>
Subject: [PATCH net-next 06/10] selftests/net: Clean-up double assignment
Date: Sat, 24 Feb 2024 09:04:14 +0000
Message-ID: <20240224-tcp-ao-tracepoints-v1-6-15f31b7f30a7@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
References: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708765347; l=887; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=ONxj7Z5bQEyPpk/sK690IPfrd/nKeK9bQ4FibvhzH/w=; b=ApyCZf2dRuD/UzWSTFlquW9P+8yF76Z2re53ax/cuKzDykILrZj070hC8QcMGoC4IwTtCZu8w C1GlruS6OfTBeWvbTf2OlH7qHOZ+wdNLNRJO1kOLmqM21rYvr8mhC+V
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Yeah, copy'n'paste typo.

Reported-by: Nassiri, Mohammad <mnassiri@ciena.com>
Closes: https://lore.kernel.org/all/DM6PR04MB4202BC58A9FD5BDD24A16E8EC56F2@DM6PR04MB4202.namprd04.prod.outlook.com/
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/lib/sock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/sock.c b/tools/testing/selftests/net/tcp_ao/lib/sock.c
index 15aeb0963058..0ffda966c677 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/sock.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/sock.c
@@ -379,7 +379,6 @@ int test_get_tcp_ao_counters(int sk, struct tcp_ao_counters *out)
 
 	key_dump[0].nkeys = nr_keys;
 	key_dump[0].get_all = 1;
-	key_dump[0].get_all = 1;
 	err = getsockopt(sk, IPPROTO_TCP, TCP_AO_GET_KEYS,
 			 key_dump, &key_dump_sz);
 	if (err) {

-- 
2.43.0

