Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792947174;
	b=O84jGhbOeu+fPsdMU2NpEWaBpTskHOQT1Xp7yTPBbjwvftLGyrIIzuzzxMA+PvX5vsMw
	 qJQD1IdXfEUoeNJO/i9ZwGhvwrL3eoCcLgzWZvylW3DQvOfFluBF16QKueB2s9d58zlxA
	 ShYY3SQGG0bLdT3K3pkgM3qQis1sTGT87MJ41XbQCBLI/pJstlTExP6Sq9KREOZpvYU2z
	 2cZKiO/7YouXXsQf2BeVSKSVCYU51yJOjRVx+gzpn6K1Zh6Ixgz8FTvclwfK1r1RS7xzm
	 Tu6yxHOzJxxrfNx4C0k68B4iMeWN7HOaqyxq4sY+Gw7y/4FofVTiGSzeyGBklLHfBLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792947174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ks5Nj1Rp6nJ8C0/sAGiBc8M5bTi1BI3WWiAy9GduFxA=;
	b=lDkxf/RWq9fhR5uRsNMIa/HFsQ1P8n/uInywMwToJwjGmPnU3bDZGMQQ1sBUsUJHJ1D9
	 18JS1Z2AELACvdQF0Q+rGH2IQzt/lGnjzdpVXKfo2aT7A1BVOeWSALLPdSqYqfyxiVmGR
	 CrB+Lxic+YJzqmmLcGHF5tyc1sCc/Twlq/OlFlHNymq6r4zuWlzrGKxK0+UanJlSecHJ/
	 sqx+NpRZ1cFNrR0Q+hF7O4kTHxCH/5AMEhDEkG8phdZUpZYwSs4zttrtkndg9C4Jp/ZEP
	 UQ95e1w8kssEjK/0Oi3/K0QybYg5HEmO5vudOE2ktEkHND2btiPf3xLfguKCXcTlH7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gO83qPJT;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5F4606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Oct 2026 16:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F5F4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gO83qPJT
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15ea896ddc8so3906999c88.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Oct 2026 09:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792947174; x=1793551974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ks5Nj1Rp6nJ8C0/sAGiBc8M5bTi1BI3WWiAy9GduFxA=;
        b=gO83qPJTlsVOuCRHiUlIgxveQCeYRw0awcZJWoKO6HvcBlwdr/EOpPOKyCo4BtQ9c3
         0OhR/DIFFl3ZhoVMSg6hQNys4+lqMr4D2qws1357RfIiF/j2p2SBomdejKMVU19hbSho
         NlqcWd1Lh/TyxhAJHRgTnWcdUNCv2G3OgqTDvf5tpjg7IYc7hqi/JlEO0ckzPad9flXD
         hKNVtyMrgp+G2qBU2otyxiZed8+M7kKzwQEUmjPuEuRCoHlkDa9Xktnmnqf7fXi/eN8h
         ZtlzrZf/UkbgEIg4dxpkUCOQ4fG5kLXyh+D5juCeltMltIS8hxxulciErWKX80A4P9ZT
         /Qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792947174; x=1793551974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ks5Nj1Rp6nJ8C0/sAGiBc8M5bTi1BI3WWiAy9GduFxA=;
        b=K5/4cBzl2MXx5LmHq6M3ZOyRw1dk/Po4ogrTdpS0ARQk4E8D6BlqcLEF7LPzImbG1A
         y16dWTN5QpOH5FlCMf3AaIusubMXZzPfYtdwFZzAZZ9ClLXZtazWR2IUi5es7Yk01tJJ
         yCkstuOTeLPAQN9a0tbDCSfKXESaqf1aPqx446zve0B7efdX2BVwVNW2CPxTuFZIkgk8
         jERJxZCly7PbjsX5WiLNic+K9QkqOr+tD1NEYan7hOIN8X2j4oozdL46Btl9NnW1IVxd
         MCfhhjWkpi1YgdUwbiDDwjbRBZT9bmtHhq3kq8epObzFgeU57//Hx8hAJUXN3aZ0sSu7
         qVHg==
X-Forwarded-Encrypted: i=1; AKwUvBzVoCBeZwUGtzy1xtkiHnWmAxJOC2JWhYJMxncfz10AIZO9xfJSN+qFKoxBs+yAYlio7kPMQNAXOZW2CkW3Ij9iJZk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIM+XbvYwBPfSEtzIzhYQWt1fV0WykNxLPWbuu8q6eaLik5F8XK
	R7Ft4AGp9wbDTzj+DOgEBfd8TgpYBeyrf1CfHxWRIu4u5G4pqT8F4M+r
X-Gm-Gg: AYBFou194xtlZmPwDnpRLb/xqkSrtf7EGCEJBY6jvgetemcinD1+726mgTsoE+ikmjd
	iX+pK2cemDr5C/cyPL8aL+KZF1SGu6JjdVjR/B9nXCX4uPqtmWdeJ8TsdVu5BUkVgXBhlMcImp+
	iBoPZyArtiUg20JDZvtsNOOq/MogY5KhTJAcJym2J8uzJr0Cxvj5zwBkXc8VoGT5meMH2FqihN0
	rd9Ao/vpExcCMPbZjxS2m0ylKSjceS7l0laVuCEtgaNPKHWT9i6ermS9PgYqX65y+o9ozj26VKk
	9UE61EoXVuAwKkWNiBZUkuG+wd+H420mhNzSrkAGjCZfLTtQpl9uUC5Zp4JDM/it/M7cnP/O56i
	UxI5KKfYRjuabaVwmEqcAf+CwUHfK/9MmZMz7K0pltydeJgZ4+dZ3DzESIRV0xoRM7aPEOXtPlR
	vSVd8ixBZHZpwFq5nq+B6VLIJjDa2pWMxIaiLC0pt5SSnZ43AziLn55PztVyOXiA0vi0QxiqL/v
	Vus25fakr1et1ukI0e6e3vANkwrx/R06WYp8rALW34z2FGmYSB+EdybgCWkmsp0WpFVtJpr
X-Received: by 2002:a05:7022:3f07:b0:144:fa57:c617 with SMTP id a92af1059eb24-19935dd7f53mr7910138c88.34.1792947173498;
        Sun, 25 Oct 2026 09:52:53 -0700 (PDT)
Received: from asahi.tail4da9e3.ts.net ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee69sm24035239c88.4.2026.10.25.09.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 09:52:53 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Free tracer resources on instance creation failure
Date: Mon, 26 Oct 2026 01:52:50 +0900
Message-ID: <20261025165250.65363-1-pocj8ur4in@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Creating a tracefs instance can allocate private tracer nodes, copied
flags and option arrays before trace_array_create_dir() returns. If a
later allocation fails, trace_array_create_systems() jumps to
out_free_tr and frees the trace_array without releasing those private
allocations. The failed instance is never registered, so normal removal
cannot reclaim them.

Free the tracer nodes and option arrays when trace_array_create_dir()
fails, then continue through the existing trace_array cleanup. Earlier
failures still use out_free_tr because the tracer list is not yet
initialized there.

Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
---
Tested under ARM64 QEMU/KVM through tracefs instance mkdir with
failslab targeting tracer flags, a later tracer node and option-array
growth. The baseline retained one or four private allocations after
the failed mkdir; the patched kernel retained none. Normal instance
option read/write and removal also passed.

 kernel/trace/trace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 97a058623f94..ad68a39a1161 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8751,7 +8751,7 @@ trace_array_create_systems(const char *name, const char *systems,
 	if (trace_instance_dir) {
 		ret = trace_array_create_dir(tr);
 		if (ret)
-			goto out_free_tr;
+			goto out_free_tracers;
 	} else
 		__trace_early_add_events(tr);
 
@@ -8761,6 +8761,11 @@ trace_array_create_systems(const char *name, const char *systems,
 
 	return tr;
 
+ out_free_tracers:
+	free_tracers(tr);
+	for (int i = 0; i < tr->nr_topts; i++)
+		kfree(tr->topts[i].topts);
+	kfree(tr->topts);
  out_free_tr:
 	ftrace_free_ftrace_ops(tr);
 	free_trace_buffers(tr);
