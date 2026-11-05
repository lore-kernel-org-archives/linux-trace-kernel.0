Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793888397;
	b=j6A02nOnwQX1a+Drb1raWsq06L/NR7FGVxrudk8GtxtkdU+gQoOZGavp+Z84rTziH7vU
	 XUD0fJ67R20OKSUlrowDvYXuxeOVgbQyovqao/vWRvpmn18Vs3xgzbzfXE5RYptvDvLtH
	 A33j2EppFkcvMSRqQV4SA4UNzdBgBT5Lz6fk6kUaxMbBtHB/e+lSizGGCclmLQWI8MpPl
	 2qdKUxNalHx6Rc1hJj5P0ZIlMUy93flrCPKFe5BcD5m9K5xWdPHqS1FoPTa5JjT9U3mqz
	 Sx7gkERIuRaUT4nEZH0cfVwUKB06lo0dY6YpbBiLp6ms41y9Y4GMZRZ3vBREgOabhDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=fVkiMhZqi2ixyREqRhA5BibXFDzbOUI516cKpXA0jJ8=;
	b=tksrPqBka9aejw5cInk71lV8Migl+RAmm5ewFHvnQGGI0wpG4MuNndC281osoZr7l8Lt
	 yKdahz/yiogVSJ/W/4Xtx8bPIGiPuKKFQICxPbGA6JKKjpl1YD8TPwNula5rIpCQNk2l4
	 PrUVzna+3ofRCQ+ENnTVuZLITShpivQYeFNtFXkWQ7GZlXf+Fm1MEVFU6QU4zNw5GjLPG
	 hEuVwAcIY6dNuJUdC5L7yOzOP5nSIsOZCkrC/AFSbC4Z/0BpAAe2D/sVGHToeqD0U2i3U
	 mXvUXk99tYuM67D00pgp+UCt0RgOld0y4JODrxqBJS45XMdz2bb9OFWW0OUpOJM027g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="blxoTW8/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A93606A334
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 14:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3A93606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=blxoTW8/
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4f55a53898cso1015147b6e.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Nov 2026 06:19:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793888396; cv=none;
        d=google.com; s=arc-20260327;
        b=kiFHmSqSVOVwsdp8MrX6dbAR1eszc8cfh96i5dIX2yghiHfwwBl8umXw8ghYBRJSpN
         g0hryW5LhTRY4LMXRFkHDENTMUALsZlf8/QlKkle3fVxCxpDvhNeN+cuxtLSyPqEYhDj
         uOaLkeTqVsVmYbUuWkWQAWMysyRIgj9rAwudGgoEJmJW5F9An9n0P76NNeDpkSsmLBWt
         iTeAU5Ev19/yVwZNoOKPycs82DFVB0xsDJ1Ja2mqO8xqHWMP0SfQXQjpEk3A0XM4dokp
         lUwS0nePyKuQG0xaXd9kS6F3U5SOwr1eUVCLFNCGyrNkGAkAJqtoCPOBSTl5w4RUpPkh
         ro+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=fVkiMhZqi2ixyREqRhA5BibXFDzbOUI516cKpXA0jJ8=;
        fh=yfkNN22imA9/cJF+2JTc79iEXfRrHOaWIuX3pS6AbqM=;
        b=W59jGYg1yqjdL0ZmgVsWYycTde5Z96BxrX5Kk0QXJk7wGD8LRHOYyMlQWpsK/cT3AV
         hJg+Z6nLuvrEzr6iS0lpMyOj5UsDo4QA8FXZlGtnBefa5iscPqEHlBJSuTZKFYHBNxRL
         VYW5gS8qRGFnsIgU1KdeLFQIaCFTYmcfUU9eNlAhvVS8rK03aN3qMzwNcWe3V8ryxSIV
         HjVM4Ur0TdQo0OFlfSdLzHA9AEeVt4vqmQ4kgJdG2udaFtnipNKN6L2t3XwZ3DLMFcsO
         53B0iLndf2mvjSGUBsTd+GuA453we8RirK2P5AA0Aq6HoW68b0FGzltxMQn0myAfxIB1
         1PRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793888396; x=1794493196; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fVkiMhZqi2ixyREqRhA5BibXFDzbOUI516cKpXA0jJ8=;
        b=blxoTW8/aNM/CWg4jHCUAhzGaosYGE2A2gzS8dwn4fw5gebO7g7UUURqaC8tK2F1XX
         ThI2g+MmlI7owPyZ/mBvX1jfaqJbecTO4KX84Jtr1jIdulsLy3kIw8/+bVhZIE/YeOov
         56jUiX26Xlcm1dFvcbeu41ltmDgvjntYvFnzKeJscT78KghaiN1xRinaeYj063m/fhV1
         kdmlM52Qz1Fga7LkCeltUP0ZrUzKP4ZVgypq2rc0Uvr0ji1joGaChCzwuL49pGeYP0kG
         GFpthhELINSBOt5Q5RTAcZVr3QOy9Z+MLYdJm93lp0trm8o5ZvGuAqF59OSAQXucZasG
         somQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793888396; x=1794493196;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fVkiMhZqi2ixyREqRhA5BibXFDzbOUI516cKpXA0jJ8=;
        b=ruF/Jg280KQgA6AAXSe7a/V6j4ETtt5Pwh1DyBSk+QuMLdLzkg43btLBAyIDRWISKY
         +VW/x/FXUp8XRHTLKiKnGza+8yKzyYEsm66dcj9HB0bbO5pkpQVy+b8+0RRN/gSW6em2
         KUpkSTuMIzv+yIJPVJNyQVaPuqbjJqAIFC+CWH7LXeFQrDuGmvulCy2L1CJLQmNRPOwt
         9w1wq7flFl/q3zY4rtSXJqWvimi3hQf8ukpNeyVLSkM/Pp/an4wMJkaMqk1hGYonEo5n
         NG260iqQZz44/D5vfqyHYvjmmU7i1xmPqL7TWi1go4QxksyiQHQV22q5WGUquHeNKZVj
         Pwug==
X-Forwarded-Encrypted: i=1; AKwUvBz6ddmioVl6gcDrvK8dT9k3cbAXABh9hKFWoKiLiC4ZECKme1ORZBcuHBiNq9TVTDZMMIfOyPN9Xm+R5gb8Hi3Lfkc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tBcZhdFbh2cfiTs1RydnBJGZYv5GBy1AsNHvm4cdxwFOwYbUZ
	wOr0IPuNm9YbkpJIW/zM8paL4UtS1o2ufdNSBpdHPMCTyEbwYaYlvOOuHOmZJC/Z2nIhuzGze+1
	QqQKlfC2RHQMEenrnoMa2flu+2C5alpk=
X-Gm-Gg: AYBFou0rlL1VKBt6P/9kSSAAsH54+ndoD5IwueqDUltjCmpimLaiEAIhk7dKduYdX1G
	xYyo1aFoBcQUk7/WaUxJk3oZvhdsrYRBlxpQ7njjRZda5JXkgrYPjk16NYyelCtnWhFcpBJZ759
	CHfFs9ED8DVR7tcI/LR1HVW9D9yrw3vbxx/bsopCgJaV899cRVLErCpVe975h+JumgBY43sKFJQ
	A3gi/fS5Ylj7HlqBH2tYZeIrhj/vtHsW9Af8xr3xLeTq6RcTU4W6Han318dRaglbH9L1Vo0P6W1
	mYKx42bRsqQLYS4o38BsyN2eFpbPXxa802tG0o3rst+PAAWl3yVTIqh4YSVdNY65+XUmZ4JdcZe
	q0qcCB+AnOaQA92TdRC+jBMQ6uuPXX9RnmpqJ4hIC+6JjIRzBAB1veo965TLB4kj0OE7k7s4=
X-Received: by 2002:a05:6808:11cb:b0:53e:42e4:47c with SMTP id
 5614622812f47-5640ddafe6fmr14880307b6e.34.1793888395737; Thu, 05 Nov 2026
 06:19:55 -0800 (PST)
Received: from 41474967715 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 5 Nov 2026 06:19:54 -0800
Received: from 41474967715 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 5 Nov 2026 06:19:54 -0800
From: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
In-Reply-To: <CADZg-m0FeLntAS6XxE-kc74vwH-jAh+jXT68qnVwXuHZNUHzfA@mail.gmail.com>
References: <CADZg-m04iG5kCZ5-yh=Vz_ysYjVDGSYn3je4_-8AzWWfiC-bXQ@mail.gmail.com>
 <CADZg-m0FeLntAS6XxE-kc74vwH-jAh+jXT68qnVwXuHZNUHzfA@mail.gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 5 Nov 2026 06:19:54 -0800
X-Gm-Features: AclHuK82Jb2KHgfgK5OPYnhW4ayXf8IsS89Dhx7joTBVnTmxHxJXKHLc-7hkZ_k
Message-ID: <CADZg-m3Wxkze0t9u1+dvn3Rrart54_eyi5XDcOSE+9W94s983Q@mail.gmail.com>
Subject: [PATCH v3] ring-buffer: Skip time delta validation for the counter clock
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot+eb74dca0d1eb3ec227a7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

The counter trace clock increments on every read. Time delta validation
assumes that the clock values read while reserving and checking an event
can be reconciled with the deltas stored in the page. With the counter
clock, this assumption can fail for an intact ring buffer and report a
spurious TIME DOES NOT MATCH warning.

Skip time delta validation while the buffer uses trace_clock_counter().
Clock selection already resets the buffer, so events recorded under a
previous clock are not retained for this check. Recording and reading
counter-clock events are unchanged.

Link: https://lore.kernel.org/all/20260920161648.7d9fda60@fedora/
Reported-by: syzbot+eb74dca0d1eb3ec227a7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=eb74dca0d1eb3ec227a7
Signed-off-by: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
---
Changes in v3:
- Replace the Openwall archive URL with the corresponding lore link.

Changes in v2:
- Resend as plain text after the previous mail client reformatted the diff.

 kernel/trace/ring_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1fd28a7..c860d5b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4747,6 +4747,10 @@ static void check_buffer(struct
ring_buffer_per_cpu *cpu_buffer,
 	bool full = false;
 	int ret;

+	/* The counter clock advances on every read, invalidating this check. */
+	if (cpu_buffer->buffer->clock == trace_clock_counter)
+		return;
+
 	dpage = info->tail_page->page;

 	if (tail == CHECK_FULL_PAGE) {

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
