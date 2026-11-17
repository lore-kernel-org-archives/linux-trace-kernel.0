Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904185;
	b=3/BgtcbzwPvWP5tqDXA9+dNyrwvUgrW1lGl7x4CpwwIukEEuSrw9hZA4DaejfSFLJ6LO
	 148OufQzk0ds/ldX7DcJc0isQlQpoiyAEYrU2PT+LpIU8CxbaNewW1fzCybPjSnby8KsO
	 SsSIpDIE8ignAOt9CANYaw5EUSUDVHbZcpbBbaetcJZlRLGNp+y1AVJSgHO29+tPndI0R
	 IcYQlB9R9auACX7YOhohVojVLP94yLb2vsUeGrWoHp4JChY40F7x80J/ulONNk8AFkV/U
	 6994Yszlwg72+pT62Sgbp67k7hy/MPgcUL2Ae+JFxBVkf+jVeuyjcS5WytpX+byNLyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ZUzJJDtkx8ZaYRA5grqqG2mwrrLwcQbjsBpMmpNBpIc=;
	b=bKAaWjRKlsCNt4pWNfiutqpDY9GaN4hcNZ8PBdc6ZE4xNHEpwSWSAe84K5OWyaYVZxrd
	 hPyPe82ngKIFR+2qi0eWqiGtPHa3G3qPgiAuMG2PMjuy3dHLugYAzUijwJNNVbR6Z34kk
	 36LdhQFpmTxxseyCDFbtgxVBRVzzg2bcf4dn1r1JKy2FlqJaV5TjV02rB1tAl0XEWSHMm
	 TaJTeaqhipFFrvzTenoRwL0P4s8is+7L29SoxGrc81d9hA54hM7YH6C36TRQWT0A2lnfz
	 2Umaz5Wfy/P8ihnbO02o5biOXTzM0HtmqGIZxhP97c2cYKGm5xM/4SkdUxXbYiFnmkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="g/40v4iR";
	arc=none smtp.remote-ip=209.85.208.70
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EDD606A889
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 08:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01EDD606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g/40v4iR
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6b3f840cb9cso6136860a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 00:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794904182; x=1795508982; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZUzJJDtkx8ZaYRA5grqqG2mwrrLwcQbjsBpMmpNBpIc=;
        b=g/40v4iRuWwI5fUGgNeFddKvD6lR7SkzcbzzaKqUiz2wL6lb7UwNmZz+mbPRRZnLfu
         +58nh0rf9C5g6LKkZflitpOi7sQyrBdkaMPtL+1aYm5pqh+lWba503aaEywfszr1qivO
         u8wOp50SmK+zDTFyswVTMAIi4oGv6LyGeyqlsGbJjExfnUQWSJfo5Sw1a2WkwLzHiUas
         Mkl9RfXrRQZWmg4S+DmWgs2Q1vIDsmMnJJFgg61dHfmG1JVu/DReyq0CxOMwGv344zFl
         TjGRzlTze1ijG1DekJK+neRJ7sfZ6ij2YRdvPKH4jAEdfgs0WaJkRo8JCNwW2F2jf62v
         vtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904182; x=1795508982;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZUzJJDtkx8ZaYRA5grqqG2mwrrLwcQbjsBpMmpNBpIc=;
        b=aZBTq20+rJN5PBDx/G5vonr0VI/iIt+ojHwJs7FlB5Uo3kfafCzinpWPNHNgagAsH1
         z2HrCtrjjtkhHivNsErrpUuWcCxrUn8kNOYdMDQWkuSgUuic/1aIFcFsjveFCa4kxab+
         /El0dYEy/nbhWyRRxPY8fAuKDkrL1EYvcMBqalSMvOtfWtleLK2ITXbxJxOjc20RwIB7
         Cv9tWyuwTaCYwBdll1yIk84eH01VosWdFEb14NS3IVJFOkU4zipwAtWKYYTblzNU9jY8
         yRlhAwJwtg7XlLitMVbuy8tsZRKdaWpbqrGti619QKUa8k6T6HEGx3yBkFjnXckIS2me
         esig==
X-Forwarded-Encrypted: i=1; AL+hErG5rsbCl2F9vy8ipE0kzExGDfLC1GJIeKEzkCt35VtsrpJJbrfW3vFzJXFW8ldZPyEkGlMzsxlUqetAhKRR8OnI9aE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yaHI0/ogrLuK/wsvAm9RRQT295KKwkpvXQqFEIJFM1tucrK5u
	6SDzhZJE2QMM1rJ9DjFsAZgpSKDfRz39k2TqnjvAaGA1bEJCrb/8FAuz/3RtPaQOYIT9kEcAU6Z
	WYHqWa9Eq3mU7GK/o0t8QeA==
X-Received: from edyg6.prod.google.com ([2002:a05:6402:1806:b0:6b8:7992:6727])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:42c9:b0:6b7:8b1:aa6c with SMTP id 4fb4d7f45d1cf-6b7c0bc4fcfmr10380043a12.10.1794904182145;
 Tue, 17 Nov 2026 00:29:42 -0800 (PST)
Date: Tue, 17 Nov 2026 08:29:32 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117082932.3441173-1-vdonnefort@google.com>
Subject: [PATCH] tracing: Take trace_access_lock() in tracing_buffers_ioctl()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Kyuwon Cho <kyuwoncho18@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

tracing_buffers_ioctl() calls ring_buffer_map_get_reader() without
trace_access_lock, breaking concurrent readers. Take trace_access_lock()
around ring_buffer_map_get_reader(), matching the other consuming
readers.

Fixes: cf9f0f7c4c5b ("tracing: Allow user-space mapping of the ring-buffer")
Reported-by: Kyuwon Cho <kyuwoncho18@gmail.com>
Closes: https://lore.kernel.org/all/179485165154.2547186.6129837870360499372@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/trace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e8c4efa8107b..456fc388a31f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7404,8 +7404,12 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
 				return err;
 		}
 
-		return ring_buffer_map_get_reader(iter->array_buffer->buffer,
-						  iter->cpu_file);
+		trace_access_lock(iter->cpu_file);
+		err = ring_buffer_map_get_reader(iter->array_buffer->buffer,
+						 iter->cpu_file);
+		trace_access_unlock(iter->cpu_file);
+
+		return err;
 	} else if (cmd) {
 		return -ENOTTY;
 	}

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.1.703.gf848ed807c-goog

