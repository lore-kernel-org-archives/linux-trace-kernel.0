Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB5E1581F8
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167822; cv=none; b=YS7nn385bw4DSJ2hl9cUFB/l//G6vyxxiXWQJbscpTuxIjsGuXb1VvaDgr4u4J/Ae/cw8OwG+m7l2WpTmF1lSn4Gm86Hf/YpfnH8CO7SnD4AkQXCtYVFJhPX0wAslBwd1FeeKNHhfuU2oxK3DCAG0rEWSjWbVZ2HoWIffU3XGhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167822; c=relaxed/simple;
	bh=94YH95Kqg56L0NGAhzRVzTprjMBr1gaZFjXLE1bEm7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5zQIbuzXjukf2RIU8obMAb3TE/+pZh93bhA03zZjFayyNa1JZNLcN/9Yn6QB83Brnx5aeBirG/ZHgxR5nnwsiVbEo2hpGpbLS9R14Z2YOn3Rp4TdTVEsCId7oeyAB295j4PRqrxDC39AAZdFZkEAwkTzjADR/J/9I1nvJ65iWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Af9HBqiN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Af9HBqiN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753167819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94YH95Kqg56L0NGAhzRVzTprjMBr1gaZFjXLE1bEm7Y=;
	b=Af9HBqiN7Gb29VlD8LpiwphXIZ91zAHX05f7cPANINO3cCc+TifQ0ezWCrPhij1q+ajAcJ
	IVL4Q4B/sDaUdOV1LfPVcb0OIvdACjvOYqTYleHoh4QY9Mu1RhX8GwhyutukPLfXcU+vKQ
	grsuWhwRtDM5dAk493pHjq5dtNp++M4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-FMufTfkwN6u9NRY0BVBXJQ-1; Tue, 22 Jul 2025 03:03:38 -0400
X-MC-Unique: FMufTfkwN6u9NRY0BVBXJQ-1
X-Mimecast-MFC-AGG-ID: FMufTfkwN6u9NRY0BVBXJQ_1753167817
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ae1c79fb8a9so527384266b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753167817; x=1753772617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94YH95Kqg56L0NGAhzRVzTprjMBr1gaZFjXLE1bEm7Y=;
        b=p+ReuUZEzBlZruWyKPt2lBC98fUA8H8Nlj+eVrgEw6W3sIO7jd2Vgh4WI8+MLqiqME
         YiSIWj5K1yNy5hA/W2Up/CE9D0zAfVPqsm7FmqTSMGVFvMQkk79JMH72kWKZGd7yQG01
         BW7eK77DTFo86eaBe0+j6Xua343F3WFiMvVNafHWIy7WcMjFQJQApkZs3gPJ57Dmvlrl
         OLxtHrM4MJFLTsoncERg4Hc5VV57Xeptv5iUeQ5xCWC8te438kp0iOfrOZ3xnNzg4I7b
         AE59jdZapRafBr4f3NucNaWodQpRY2HdRjyHWHzhA0W1HlBiBQnd3tZVLoQL8yNntIGd
         pIqg==
X-Gm-Message-State: AOJu0YyDuMcTCnDCHfX2uYB34jPd3bpG5/gUTbdlYlnQTDxyIPfOytCP
	eiZUZAlkA9KmFnFCbn0rF6Tgi3xnnjqpXXcbchMHBuzMfaQoPN1VXuVt/KFMaFxjvOdGhvIWIel
	k7rGA9kuNBmSFKsm9B2rOIqx4JHeyVkDY+6t/qJaXl9PoyyC3hNUurzYI3TzxswHG5bmK+WBpM+
	5qhZTP/5OzplzgR5yj1LroHvL9ab3feDGl1zL6Az83//zohhN9
X-Gm-Gg: ASbGnctywktwWCpenBun3Bc49Rq8J1qtf9mrscAYEL5wzCA8h+hVWBd9ypZGOvHM/qo
	EO406dZNCDkTir+dwZ11gvMAwL1WUtw1fWHkspOaHb3UJvwqZtMsYuVeDHJDq6LWgwkCQtwGQPT
	V9soZqdtdjMMNgNiFia8k=
X-Received: by 2002:a17:907:724c:b0:ae3:6744:3677 with SMTP id a640c23a62f3a-aec6a5fa9f8mr1431815166b.32.1753167816583;
        Tue, 22 Jul 2025 00:03:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUS1C4M+sqJMBlVVOE3zFSmnosEzS/DCoJtMWBdNIwIY9r/Y+OIaF5oI+nbiWF7pf7JaO7/YLTOiG/Al9Kfl0=
X-Received: by 2002:a17:907:724c:b0:ae3:6744:3677 with SMTP id
 a640c23a62f3a-aec6a5fa9f8mr1431810666b.32.1753167816060; Tue, 22 Jul 2025
 00:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626123405.1496931-1-tglozar@redhat.com> <20250626123405.1496931-10-tglozar@redhat.com>
 <20250721183606.0489b1cd@gandalf.local.home>
In-Reply-To: <20250721183606.0489b1cd@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 22 Jul 2025 09:03:24 +0200
X-Gm-Features: Ac12FXwIQm1h_qa8RXimPv2lpTVEqVoAuExH-2hEnAe5PwJDJ8uOLrUDIYGzoxI
Message-ID: <CAP4=nvQWCWAOefHAqA82-VDb-00_y1-0fPOPBEyETJ2Q1EWEwg@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] Documentation/rtla: Add actions feature
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Chang Yin <cyin@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Gabriele Monaco <gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 38zZbf9WSwkqfFABmn5JkNK-zNtZU5jYgLUDambfO5g_1753167817
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 22. 7. 2025 v 0:35 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.=
org> napsal:
>
> I'm curious to what is looked for for triggering an action. We can poll o=
n
> events and get woken when they are triggered. It may be possible to add
> even more ways to wake a task waiting for something to happen.
>

Threshold actions are triggered immediately after a sample over the
set threshold is detected by rtla. For BPF mode, this happens almost
right after the sample is processed in the BPF program and the
scheduler gets to waking up rtla following a BPF ringbuffer write.
There is only a short delay (up to tens of microseconds) because the
BPF helper defers the wake-up into irq_work.

For non-BPF mode, rtla periodically pulls samples from tracefs, when
it does that, it also checks whether tracing has been turned off. If
yes, that means there was a threshold overflow, and actions are
triggered. Since the period for that is currently set to 1 second, the
action might be delayed up to one second from the threshold occurring,
That delay might be a problem if you need to collect a lot of data
from a ringbuffer in the action, e.g. global Intel PT data collection
for precise troubleshooting of difficult latencies.

Of course, this is just an implementational limitation of the timerlat
tracer. If timerlat had an event (like osnoise's "sample_threshold")
triggered on threshold overflow and if it is possible to wait on it
even without BPF, rtla could wait on that for both BPF and non-BPF
mode instead of what it is currently doing.

Tomas

