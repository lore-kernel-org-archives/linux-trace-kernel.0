Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53E52185AB;
	Fri, 23 May 2025 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962633; cv=none; b=JjPloKbeRebIlEQTafN2em5Vk6ofoXhoTz63+TiWTS9HBGCgVegFAu0wu0SjTEvZYPEcQRUxYMi3F/FQeY74xzHh2W51JU+PkD+qd1frCrNjR93NNnb2hOLFtjgl//tH7SPrQwvy/e2wQq358EMIJB9ioxWg8oDxi6UVPAmOa/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962633; c=relaxed/simple;
	bh=HJDZppco9G3LuBRAb8iWUfFcTNZXTnripw2WRCoRuhw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FNPSHgoPWCXfGk352if8iS93P5P0sKwBi1GZmXHYWT75KK9uk2oXMvXUWuwS7o70VkEpShR/z3NVxS99jIv4nZrhnj0f4S/9aWwIxeiwXuTKUjy7Fqqu+9fIvNUc8OsawF0EbwZHEYKhVgl6ms9cdQN7Lv+2jGh/AVSQyc/WjWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KONZ3bUV; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KONZ3bUV"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32840b91488so64342761fa.0;
        Thu, 22 May 2025 18:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747962630; x=1748567430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HJDZppco9G3LuBRAb8iWUfFcTNZXTnripw2WRCoRuhw=;
        b=KONZ3bUVfFLZpy9gw0ptuxNyYmyNSqs4XjmDGY6Q8xQkII2P0oSZVgAoqPQSper7Is
         ABDH/YhsHxxG+9XOSDunGsZ6DQXf10D7sBoghodEV01lezsdW1Lqg1exQEn39miGsNcO
         v1i6lj2dirFhQDdadhdNMQrXrj0GppjtKLK2pKZRV1juAzhuyIxJ1duriUqP/9Hi+LA4
         eOL4peIICIvDF6LUEv95cRLnk2MctF5cYIwCTohH+3fUtVyy4MpHOfCM10GKYjn7POkF
         nivUj516IFKmROQBlO57usVInZk75Q/WZVNIcnTR24xowIDuvI4Wwcckj/wOjJFawe4I
         B/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962630; x=1748567430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJDZppco9G3LuBRAb8iWUfFcTNZXTnripw2WRCoRuhw=;
        b=i5ZvCvuRgClut8jCVhlDX8ko8NwNVhEkJciGC3uMVJtgtxN1AH9taP4tQ5k8WuHcxE
         KogyvkZGT3fZ6B6Kl4QsOoVUjeZYhTvoNZzeM3Nc+txYKJnCRlndESAo/i+j/lCNiAhZ
         38Kg1TKYZ8+LIfT/JnDyuTmDB0l2JebjCJtqeWTzmRfSNkjBPKT9I3nikK3jXcUI92Sg
         /4xXyWPOXJxe4T4mFl1WJ4/KYFm3IJYQFv6PGNzVaAZKY2M3Hl1rRkdJSAQGyzaJqFtq
         Oxa5KnqBW4zHSgbIxqjp4uCjUF9hT0867hiXW5UXXM1qqS5+ghkDkhuPD5yLNxnUkg2A
         nJvA==
X-Forwarded-Encrypted: i=1; AJvYcCV9g6rKzhpriJq44w/1O2C7Igigyonc6ViSNzcOS27SnI1b3UK1ZIxmVZk5dllOa/QUJE6XeHd5wVh6N4zf0tkSbOr/@vger.kernel.org, AJvYcCWOafVyDt++KGSZxE9vjH0YFtSnDzv/KmJ/Q3wx4dJBKcMsK3wkaSzQ+WqjKKzvNG7N3Braud57Rck5lxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUwm/6by+CnejfRpoPKsz9TyJmcdyVEQzo9Ytus/QkSpJmzvSN
	J81VpLOovvbJXDN/WPR8RhHtKyioHEskZ7wrfIx++JiLX9S622bK99jIN/qAOi189xFOHC09FjW
	y6GaH6huZ6g6d4ZoV+X+MhiZ2P3jHdTg/eXBAuSCU
X-Gm-Gg: ASbGncvKBa8Fhy+x4rj7c2UW8tJNXWSw2BDXTHE/AdM6wrtFVjJT3r47zHmPcRcrQg9
	KlN49pynj/tA6HwAMT6aOYi4CnEJdlDj7XKcSQNeGmkwXCR3Cbq2SSBBjMRPe4ygvYive/YcHyv
	ybX+x+owcGhwD+haX2gvAGoAf5uM3c3Yq2pjsywIir0MpeQVhsGSV77g==
X-Google-Smtp-Source: AGHT+IHTBT/a9Uv7PlgN6Yf3dlKAmhHgALwlrBbxq9h6ybNRapYU9k7nAnDtC3b5lMTvpQr5w132Knp6N0J7Lc/oSJw=
X-Received: by 2002:a05:651c:150e:b0:326:c36a:bd63 with SMTP id
 38308e7fff4ca-328077c4059mr116488321fa.29.1747962629510; Thu, 22 May 2025
 18:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John <john.cs.hey@gmail.com>
Date: Fri, 23 May 2025 09:10:17 +0800
X-Gm-Features: AX0GCFt26o5CwloUaJg8BvGg_i-kt_621MaX0j3h_75Rf5-hp2HRN0XrfVqFj5w
Message-ID: <CAP=Rh=NewbpXABhEECGAfBaA_1XtijWDhrainjuKZc6WYXrQZg@mail.gmail.com>
Subject: =?UTF-8?Q?=5BBug=5D_=22soft_lockup_in_inet6=5Frelease=E2=80=9C_in_Linux_Kern?=
	=?UTF-8?Q?el_v6=2E15=2Drc5?=
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.15-rc5.

Git Commit: 92a09c47464d040866cf2b4cd052bc60555185fb (tag: v6.15-rc5)

Bug Location: 0010:perf_trace_buf_update+0x19/0x190
kernel/trace/trace_event_perf.c:429

Bug report: https://hastebin.com/share/udusequyew.bash

Complete log: https://hastebin.com/share/ibalexehon.perl

Entire kernel config: https://hastebin.com/share/padecilimo.ini

Root Cause Analysis:
A soft lockup was detected on CPU#0 with the instruction pointer (RIP)
stuck in the perf_trace_buf_update() function (at
kernel/trace/trace_event_perf.c:429).
This function was invoked indirectly as part of the inet6_release()
socket cleanup path, during the final phase of socket destruction
(__sk_destruct() =E2=86=92 sk_prot_free() =E2=86=92 tracing path).

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
John
