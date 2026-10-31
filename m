Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793480666;
	b=iGpTx4Q/XPlE1Y/ZpkvI1MEL4Uh8qPcyxc8RlonQPoVCf1DjEYPq9/UJTogEI3sNzPiW
	 eB8l8yh6S4+yV1MFCJsJF8OXhu+LyNXiIqCmDjXn07raPlijAHLeESC9mHUZja0LOe4Tm
	 JpRrguQSseHI1VIOKRDJ0zOmIGKbZeC4bwycEzrV1IMjrclQyEYrzlO0yl8IiPjp8Wk2X
	 beKwKBCJ8Duhrm2wA37Miuf4i238Oj90eDHbvYLpqyl5Xr9knTNgjPpgWw0dbMLjW8aDI
	 Dmf+H9o00ceYc8jj4BrR/FTyeOZKrgAoJnlhkauEMgCTwdP+Q6WWoYR93hRy7DvsxeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793480666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4szFGphMtUoKYDwEO3ILc85/4qEVkI9CTfJtlLVXdJ8=;
	b=SPZC3qkyUNUyNuHTjiHsJVWjHNS5pSnXHSOsEjKcPYVoXbW3EgJS1hDlr1YiOnXoVbDK
	 kFi3RIpAemwiDHfyZb3C9ayYy7UzdaYG472nUJge66gwnMmTmemd5EOyte9q4tQwWznBh
	 Zm7Vmy6lW+t6iQfftY0PaLJMfDZl//dBwXJKwoJzzw+jGJQrkl6ORP/FabcuPh6eHo+26
	 MqL9FBH0Mhrs6HmbQAi1VE78/3N32n4aY4+il3Hzsd+509BR65KX05gTUQtRFwgNAqyxf
	 K1u4+/prJTSiCpfqiujkbuoxwE1rKE/mlH5yOWzkBs0flK3VQ+tZbS+H0WLTGNm6a3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zv+gfP3h;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADE0606A31E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 21:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ADE0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zv+gfP3h
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so14627155e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 14:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793480665; x=1794085465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4szFGphMtUoKYDwEO3ILc85/4qEVkI9CTfJtlLVXdJ8=;
        b=Zv+gfP3h0dCGmKQSZJgc9BXKNly7hCWlQkiAVteubsCa1u8VJ8/1FknfrfEcBt+UkT
         mOnyh6DWoAmpnQqC81pg58KWwTDOT9GxDj1gRLyayrMmXzDhpHmc9aIQT0Ulc3qv9X9x
         IePk9f+V2iIgPxdC/nJEzxDizOpW4wiwUb2U/RNLyQtG9VtPjEQqmA23Sj6PQPmexqMW
         anVZDFm1hcJSP8zcwfreAaYqg3gklAghiV2RgGjgEumSkmteloWLAJCDnAPnUejHy6xp
         RUlG7Y5Y1YMBYmWPwNz/xMwU7JeVpsvK5YtHqiudSHqfmKGFrt7CfHw3qhBD5xQc80i3
         or0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793480665; x=1794085465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4szFGphMtUoKYDwEO3ILc85/4qEVkI9CTfJtlLVXdJ8=;
        b=NWzqJSB+quuM62D2SbsP3nxI7J55sjHsBboAarmubt011qE8ItOiJ7d7vFW4P8Vb0V
         bGe79w+2nNGpnphRSRl2ePw1lO8lCQvl8W8iREPUovLMZ04mfABvZILqx3UbwEp9mgkK
         0BP40TqLTH5nqUNMJMjzf7XjSlBxVRKa5nHoknFCVgQtSeLGVobzSjuuZGYT/J/0qQzE
         9Zlda+hCP6WGkV68qQzUdwEa3jp0556S3ANqRyNLcgrDh1rZnXyaOzg1PdEmCVUPL61F
         pO5rwFCHu4azwz+UnwB52R3F/UPu/bOs772B/PTYEYiTgAzYfXGOt8wNccAVZurohmcv
         zPOg==
X-Forwarded-Encrypted: i=1; AKwUvBysp0g4wJkQu1mNx8A+4vlqQK97oBQpW4aO7++VvvYimZ/0X/q4qjdKh1Ek7BVnsnWqoweo07O0erShJcHbk5JRcpc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJKLePh9uHpZAb0VbRRuN21vxShqUkr8RFMWYlbW8o14QJOwHK
	LJeperJrZhFDbrsC2ORzjSXegVdVg1WTXwstVGkAgNMissw/dFi9BwWo
X-Gm-Gg: AYBFou0DGyw+PLjnl1awAZpEZl4wuGQvG2wilhm+woPFwfq+yEUb99J1FjReX3oMXa4
	lC2HdNEoHRUq5Vbbc+bGOwc1y/pslThBASALpEq/TeQh/gv4yyap+ZAWbqeLylAx+puPUk1CTmV
	d5f3lVU+uynuFkd3JcRny07vUq6T5WrtC8/Yfmoqx67787NY6kuMqcz6IHQu2cb2fKBE66Xnmi2
	k60B+rJtxk/zoPqJtst0704SP1+FSMKEQj9S/QLL79DL0o0NNR2bdGSdb75TkJi829gPDtORdKr
	KZWKVvE4PrZghufzRr6Pem4tGyvRsKxy9RUbRNJqyKekw2JXv9qErqP4nHLnPlVkIUJcXHXynO8
	ToVEGZqHdzHm7D3RhKjGJX+mNNuklSYNmS5ph4R5wOIWCJfIvBahxFCq9Rt2iqKmUcHlvQLu6My
	EgyU/d9nzYGQKKNhm0EKjD3WvizN8nKRNU5Gp7pmOxkypIyOXZihOiBemM7lDvlcmUCJdBxKmEz
	uKWWN1Ok79kzZh2jntwgHp/JaqcaY6Aryqlz1/jqoAn0sXn0y+HJt1R/81/q5lNkLeJeFRV3vHH
	JvcqZJdSIfPKF3QQg/4RMoAO6ztzEAO6hI5ROb9k+4zZle3/UDL10tdJhvkGs238sl+QtQkLwBc
	71vz30cJ63UaaGg==
X-Received: by 2002:a05:600c:6214:b0:4a2:9cda:57cb with SMTP id 5b1f17b1804b1-4ac151a9077mr149862625e9.1.1793480664317;
        Sat, 31 Oct 2026 14:04:24 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abea72254csm82768725e9.1.2026.10.31.14.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 14:04:23 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing/user_events: Don't free an event that a dynamic event still references
Date: Sat, 31 Oct 2026 21:03:59 +0000
Message-ID: <20261031210420.501187-1-devnexen@gmail.com>
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

An eprobe takes a reference on the call of the event it attaches to,
and kprobe, uprobe, fprobe and synth events all refuse to go away while
trace_event_dyn_busy() says such a reference exists. user_events never
checks it, so a user event can be freed under an eprobe:

  echo 'u:test u32 a' >> dynamic_events
  echo 'e:ep user_events/test a=$a' >> dynamic_events
  echo '-:user_events/test' >> dynamic_events
  echo '-:eprobes/ep' >> dynamic_events

The last write drops the reference on the freed call.

Return -EBUSY from destroy_user_event() in that case.

Fixes: 7f5a08c79df3 ("user_events: Add minimal support for trace_event into ftrace")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
A non-persistent event whose last fd closes while an eprobe
holds it now stays registered after the eprobe is gone. Can follow
up with a retry on the eprobe put if wanted.
 kernel/trace/trace_events_user.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index f658c3a77aa7..49b857a7f1d7 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1506,6 +1506,10 @@ static int destroy_user_event(struct user_event *user)
 
 	lockdep_assert_held(&event_mutex);
 
+	/* If there is a reference to a dynamic event */
+	if (trace_event_dyn_busy(&user->call))
+		return -EBUSY;
+
 	/*
 	 * Detach the fields before removing the call. Removing the event
 	 * frees the field list memory (trace_destroy_fields() is run on
-- 
2.55.0

