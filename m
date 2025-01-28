Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F1C199FA2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Jan 2025 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738063856; cv=none; b=u0rEwoUNiWJkF4bQ5bATfMkjl2F2g4JOB8u54Kmd4M/PXxyKykx1zn1+tfqvUCwGzOYCNT10Yfak5td3bA9pNQkbK4AgRWxk/PgxsE1+EuN4yQ6eeP/7rzbiId2ut6bN59Qi0joeN4+JXcSeTDtsSiLcSyZPTWtLf64ar3hv9e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738063856; c=relaxed/simple;
	bh=Hf5HRm9odpSQPQjqkrsFQTQWBdFAgyNefgMQkJQL9H4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0FQPywpXh/HNDv4J436yI062XbE9IOWFmsGd4igInxB/j/cPrnPTr3vUXod4gqvuFOIA2RdsmTjoeWSUceVS9DOYDhzuaW0wdJuv+pAYCqpDm6oYtMpB1yGjRTQoIXy27y0lbH0tIaF+emmc934WeK33yvyuQIiFPVdeEoeCYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TB5Fra8Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TB5Fra8Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738063853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Hf5HRm9odpSQPQjqkrsFQTQWBdFAgyNefgMQkJQL9H4=;
	b=TB5Fra8Ze5suXO702rqj3xlSjIuqI/9uJ8NZRD3ZB+oxqwWNKzOqu5O/+fFk8BvU7A34I0
	jW0arRR/jZ5kYBgk0+jGzjtq8ityRX1IMIYZ35L93khnY1SZ0WP/RTHKxcSOOddF/JBKJN
	iX0YTSKWRL3z2VVHUQM3owjgaI0xze8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-ht8OzrtvPZaKSY-RKz6jZA-1; Tue, 28 Jan 2025 06:30:52 -0500
X-MC-Unique: ht8OzrtvPZaKSY-RKz6jZA-1
X-Mimecast-MFC-AGG-ID: ht8OzrtvPZaKSY-RKz6jZA
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6ecd22efbso1102574885a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Jan 2025 03:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738063851; x=1738668651;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMSF7Q3H3oy1kbJhB6KKPKHXVWwzUgKVVNuL0gZFWNo=;
        b=ETHNOPdQs2wxI+Mr/c5Wu0c9KEXMKrj0XZ9r7aFFsFFlFHuYMnJrK9xlDZm8+egbVf
         IYkztFShjFr0fOh3P0Qv+wZ1kREzkR8QFkEft57GvjVOJmct5cDMxlax45cLLx4URIK+
         MQIcAUyoz46kGr6Pq1LOOEr8jho3sax4Ln9MiQCXCJrHn9AILiyeEG+ga822rwtKbYVU
         ygPyWrWZNmWsxa+B3S6iVxU8L9MVVJ8D+j6Hy0MgtFms07hs7AbCfJIFSQSYXT/kZJ+W
         SdXeN0cnQTg+FEz/3e/SFnQmeUy4VcbWDjPZ3ymT5my8H2t4GzdkE2KoElgsU8VvMjEA
         5OKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMUq6sOQnkw7JtkFfuhQOrRO5xwkfmiUM/HZanxJ9h5LXuWnuz4dPcWIr2yk0ZQ0SSDWSEnVJUFffPIPhcg8AC2mI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ZB2Yk4T/J3AV1uQmK+U+i9sCvhY9gnAKsS75V3tft0PnQ9PH
	rLPKPUWmha3cn/4LRsx52aUIqD8inMvBGvdo2v+PLzq1cG+/aRZGSEBy9bEcI3CNCg6otI51b8w
	eFBZkqG3ghGZ79Y9T0c6mOK/X+V8zi2aCX/0c20AHss0cOIAAhWCkldgGp7gCpuTThYK15w==
X-Gm-Gg: ASbGnctKG1vdwx6ERgnZg8ZrNuqog+sOvBh8MsjslZAftrnnItm+Ybbvua0S3wq9wQB
	bX9vFos3ttKo65R4+/xlNVut03LGPEYnmY7yVVzB5eqfIwaiur1E1Bc1MSsidI5oxYZn8M+P73I
	RIlxECNbfAPScjcEJ2x5eJySsv1PWxwqUNX1A0e6vHJduGpePHAg/7ggDsTvowus1yyO5KOjTUM
	ALjhUVfEubhZGsBkJ+X/45XsWRlJ+kS04FAk1SDsLt63VmqmPkHllcPU/Hf2BW+ZDhD7dtX3qQD
	SoKgtci0N8zsvKjGZXhr35Q9/hFkxVo=
X-Received: by 2002:a05:620a:319b:b0:7b6:ea67:72d0 with SMTP id af79cd13be357-7bff3f5f219mr482947285a.4.1738063851687;
        Tue, 28 Jan 2025 03:30:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHUu5ML3jjMJyodEANNFw49gg+MXot7/xL7svpr6FHhGC5kAxSib1gXRz0cyRxHNXd5oaxyw==
X-Received: by 2002:a05:620a:319b:b0:7b6:ea67:72d0 with SMTP id af79cd13be357-7bff3f5f219mr482944185a.4.1738063851351;
        Tue, 28 Jan 2025 03:30:51 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9af11a3dsm496057785a.109.2025.01.28.03.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 03:30:51 -0800 (PST)
Message-ID: <2660636b8e9d14f905b161cdf499082952bd2030.camel@redhat.com>
Subject: Re: [PATCH] tracing: Fix DECLARE_TRACE_CONDITION
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Tue, 28 Jan 2025 12:30:47 +0100
In-Reply-To: <20250128111926.303093-1-gmonaco@redhat.com>
References: <20250128111926.303093-1-gmonaco@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B7devEjEfqoKIWWqnWUFqpHQD7xYDYpnGVswtKm6XFA_1738063851
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-01-28 at 12:19 +0100, Gabriele Monaco wrote:
> Commit 287050d39026 ("tracing: Add TRACE_EVENT_CONDITIONAL()") adds
> macros to define conditional trace events (TRACE_EVENT_CONDITIONAL)
> and
> tracepoints (DECLARE_TRACE_CONDITION), but sets up functionality for
> direct use only for the former.
> Any attempt to use DECLARE_TRACE_CONDITION fails the build.
>=20
> Add preprocessor bits in define_trace.h to allow usage of
> DECLARE_TRACE_CONDITION just like DECLARE_TRACE.
>=20
> Fixes: 287050d39026 ("tracing: Add TRACE_EVENT_CONDITIONAL()")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---

The macro is currently never used, I'm planning to use it in a future
patch.
Likewise also DECLARE_TRACE_SYSCALL is never used and would fail the
build if used. I'm not sure if the macro would be of use in this way,
since it's missing the reg and unreg parameters used in
DEFINE_TRACE_SYSCALL, one way not to fail the build is to treat it just lik=
e
DECLARE_TRACE (as DECLARE_TRACE_CONDITION).
I can prepare this as a patch if it's the intended behaviour:

diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index ed52d0506c69..497a5a2469dc 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -80,6 +80,10 @@
 #define DECLARE_TRACE_CONDITION(name, proto, args, cond)=09\
 =09DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
=20
+#undef DECLARE_TRACE_SYSCALL
+#define DECLARE_TRACE_SYSCALL(name, proto, args, cond)=09\
+=09DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
+
 /* If requested, create helpers for calling these tracepoints from Rust. *=
/
 #ifdef CREATE_RUST_TRACE_POINTS
 #undef DEFINE_RUST_DO_TRACE
@@ -114,6 +118,8 @@
 #define DECLARE_TRACE(name, proto, args)
 #undef DECLARE_TRACE_CONDITION
 #define DECLARE_TRACE_CONDITION(name, proto, args, cond)
+#undef DECLARE_TRACE_SYSCALL
+#define DECLARE_TRACE_SYSCALL(name, proto, args, cond)
=20
 #ifdef TRACEPOINTS_ENABLED
 #include <trace/trace_events.h>
@@ -136,6 +142,7 @@
 #undef TRACE_HEADER_MULTI_READ
 #undef DECLARE_TRACE
 #undef DECLARE_TRACE_CONDITION
+#undef DECLARE_TRACE_SYSCALL
=20
 /* Only undef what we defined in this file */
 #ifdef UNDEF_TRACE_INCLUDE_FILE

