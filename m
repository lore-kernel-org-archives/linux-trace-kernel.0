Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFAA1EEE7
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Feb 2024 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212377; cv=none; b=CFxMRQF8Ox22yYCRpsfLS+2OJZESXt8tflzz3cj6G09ioJ4X8DRm+DBznBvt/lHaXLPVPIHgVB5S6RemPLXZbIqbkgpknuSUYAGqfn4Y+xVB/mF+P+BtTANYSFDfvWZD2WHMy6JN/V9+Dfi0fOVS9YbSy1kAUz+OxmSZUiXzKbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212377; c=relaxed/simple;
	bh=Hzm6uJe/+02XrZZu8RN8174KCWyUOb7ocl2V0ex4wA0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LlGWrDi31aVMddrxeA5sHcyJ0v0JToUmsfZebOZWjYcR0BqlixhdoO4sg7zWRh0ObGOqccFjVfsiz4uWlidDfHKx1s7iYtQdnqgVolSpNl8HcB8PHLAl+PkkyjpaR7Vxh7kpsmy0b0NRJkHo7izveEdaCONhqpRwuCcdwoQ6e7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJqtamYQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJqtamYQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707212374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/7CI+8pCL23lwEeB9jV5Pnz71EuQENJNd20veI5t9A=;
	b=OJqtamYQAkEBRMQXZM80t+8EbPCglMuSUIgB3tzCirICTZ2hALDZQ8lycdNR0Oypi88A8+
	BtnWhlwKJdgzgghDDk/55TTPkebu/t+HMXnTprXAmwo+NQ5HaLaSKfCQKpP8DNsTOBnNFx
	YsxjpRple7bB9XPs2Jby6emaa69+zcA=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-4ai-PmmLNm-JTt03046g8A-1; Tue, 06 Feb 2024 04:39:33 -0500
X-MC-Unique: 4ai-PmmLNm-JTt03046g8A-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so10587626276.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Feb 2024 01:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707212372; x=1707817172;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/7CI+8pCL23lwEeB9jV5Pnz71EuQENJNd20veI5t9A=;
        b=P39qDiFJ0m0OsZQXaljnMQxug7H9YSRDgFSbeexxqzW+SMQRAS/IEGH8bvzYYsJYqX
         FAoculUJdNgYgU82kJBKBavm/112yEVIDd4sNQj6RV5peU+pT4wyjeu2oCMT1k9VhNLD
         KYQX2yjZDAQqgLOCYMBvDSYI7a+0bNb0dlw1Cm9yQD7fOzrcYayotK919uwXhahpoyx+
         gNKwKQ+jn0syGG9F2rN9kpm8Jz7MB4f6NZze4tnc9/5sbxRUlsEJ3paGaQRMb7YdFIQI
         5T3nIKQChXvFLJAmqA1OoD/h3yvLQr7eLndUais2+4Qfgc4G8XhcssxES/rX9Mr9wuun
         D1XA==
X-Gm-Message-State: AOJu0Yw3Bd5lAjtFOCaV+x1ZE228KrRiGVK4OxrzjheFitlgSaCph9Tm
	y5hV5emI8AhPTGAvi4HaqKSqtpeeri4c89Cbh/wbED+TeSJACsxIWfLJIqBelhhR8zOtN58NnJb
	NjqGU1Go4OBMc6aJPNmcqU0F9anaBc8MLQ5IiS2a9P/3dJBsZwFxtvb7g5aZubS+NkZ56WQ==
X-Received: by 2002:a25:fc0a:0:b0:dc2:53ad:9a3f with SMTP id v10-20020a25fc0a000000b00dc253ad9a3fmr1003460ybd.27.1707212372685;
        Tue, 06 Feb 2024 01:39:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKW5bxqkmsCZAcyBN2N5QeK8+96q4ZC52k3JBgbyf5y7ZVNlLjY0lPqcsOVZxmTK7ajkDs5A==
X-Received: by 2002:a25:fc0a:0:b0:dc2:53ad:9a3f with SMTP id v10-20020a25fc0a000000b00dc253ad9a3fmr1003453ybd.27.1707212372360;
        Tue, 06 Feb 2024 01:39:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXPhykB3UlOuoBYPjsSwVyeo5lv0rXUgwP+19a8wTbyc5UXBh7A3jwT7f/xXTKJiDjAjKJ7O/PC2HsswotvokV8ubzq6284KYGl/RxcyvtM4Y229I5KYabU+J7O5yDbV0gUqHG/T6iN/1uYFZqG6xzymNUN5nuT5uF9Nw7QgTDNd30MlYctXBjFXHmYQo6FU3vajyhS6grVHf7WhgymQCJ8J4b0mJLoIKzX1JlzEHOs1yD6owesBot9rewH/yMvJeeaBMpYc5d04H4oMsgQ4AdhOiQ=
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id a19-20020a05620a125300b007858a7f61e8sm738069qkl.27.2024.02.06.01.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 01:39:31 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: richard clark <richard.xnu.clark@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, nico@fluxnic.net, mhiramat@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: Question about the ipi_raise filter usage and output
In-Reply-To: <CAJNi4rMiGcP4wdA=1dSOXwYXOKSCWnN8FYxBaFdaAXBqAU_ePQ@mail.gmail.com>
References: <ZcDwoce6Ok25K6Dm@FVFF77S0Q05N>
 <xhsmhmssehp6t.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAJNi4rMiGcP4wdA=1dSOXwYXOKSCWnN8FYxBaFdaAXBqAU_ePQ@mail.gmail.com>
Date: Tue, 06 Feb 2024 10:39:28 +0100
Message-ID: <xhsmhjznigcdr.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/02/24 16:42, richard clark wrote:
> On Tue, Feb 6, 2024 at 12:05=E2=80=AFAM Valentin Schneider <vschneid@redh=
at.com> wrote:
>>
>> The CPUS{} thingie only works with an event field that is either declare=
d as a
>> cpumask (__cpumask) or a scalar. That's not the case for ipi_raise, the
>> target_cpus event field is saved as a "raw" bitmask.
>>
>> There /should/ have been a warning about the event filter though, but I
>> think it's not happening because I'm allowing more than just FILTER_CPUM=
ASK
>> in parse_pred() to make it work for scalars. I'll go poke around some mo=
re.
>>
>> Generally for this sort of IPI investigation I'd recommend using the new=
er
>> trace_ipi_send_cpu() and trace_ipi_send_cpumask() (for which CPUS{}
>> filtering works).
>> If it's only the function call interrupts you're interesting in, have a
>> look at trace_csd_queue_cpu().
>
> This should be supported by newer version kernels like v6.5, but I am
> using v6.1 and this trace event has not been supported yet... so ipi
> is more suitable for me. ipi_entry and ipi_exit is ok, but seems the
> filter doesn't support a specific cpu, maybe we need to add this?
>>

You should have access to the generic fields which include the CPU from
which the event happens. Any of "CPU", "cpu" or "common_cpu" would match
this.

So if you're on a recent enough kernel (v6.6 or above AFAICT), you should
be able to do something like so:

  trace-cmd record -e 'ipi_raise' -f 'CPU & CPUS{7-42}' ./foo.sh

If you just want to match a single CPU, or are on an older kernel, this
should work as well:

  trace-cmd record -e 'ipi_raise' -f 'CPU =3D=3D 42' ./foo.sh

For example on a QEMU x86 environment:

  # trace-cmd record -e 'call_function*' -f 'CPU & CPUS{3}' hackbench
  Running in process mode with 10 groups using 40 file descriptors each (=
=3D=3D 400 tasks)
  Each sender will pass 100 messages of 100 bytes
  Time: 0.396
  CPU0 data recorded at offset=3D0x738000
      0 bytes in size
  CPU1 data recorded at offset=3D0x738000
      0 bytes in size
  CPU2 data recorded at offset=3D0x738000
      0 bytes in size
  CPU3 data recorded at offset=3D0x738000
      4096 bytes in size

  # trace-cmd report
  CPU 0 is empty
  CPU 1 is empty
  CPU 2 is empty
  cpus=3D4
            <idle>-0     [003]    29.704387: call_function_single_entry: ve=
ctor=3D251
            <idle>-0     [003]    29.704388: call_function_single_exit: vec=
tor=3D251
            <idle>-0     [003]    29.705950: call_function_single_entry: ve=
ctor=3D251
            <idle>-0     [003]    29.705951: call_function_single_exit: vec=
tor=3D251
            <idle>-0     [003]    29.706462: call_function_single_entry: ve=
ctor=3D251
            <idle>-0     [003]    29.706463: call_function_single_exit: vec=
tor=3D251
         hackbench-962   [003]    29.706501: call_function_single_entry: ve=
ctor=3D251
         hackbench-962   [003]    29.706502: call_function_single_exit: vec=
tor=3D251
         hackbench-955   [003]    29.706521: call_function_single_entry: ve=
ctor=3D251
         hackbench-955   [003]    29.706522: call_function_single_exit: vec=
tor=3D251
            <idle>-0     [003]    30.101812: call_function_single_entry: ve=
ctor=3D251
            <idle>-0     [003]    30.101814: call_function_single_exit: vec=
tor=3D251
            <idle>-0     [003]    30.101897: call_function_single_entry: ve=
ctor=3D251
            <idle>-0     [003]    30.101898: call_function_single_exit: vec=
tor=3D251
            <idle>-0     [003]    30.101985: call_function_single_entry: ve=
ctor=3D251
            <idle>-0     [003]    30.101986: call_function_single_exit: vec=
tor=3D251
            <idle>-0     [003]    30.102072: call_function_single_entry: ve=
ctor=3D251
            <idle>-0     [003]    30.102072: call_function_single_exit: vec=
tor=3D251
            <idle>-0     [003]    30.102161: call_function_single_entry: ve=
ctor=3D251
            <idle>-0     [003]    30.102161: call_function_single_exit: vec=
tor=3D251
            <idle>-0     [003]    30.102250: call_function_single_entry: ve=
ctor=3D251
            <idle>-0     [003]    30.102251: call_function_single_exit: vec=
tor=3D251
            <idle>-0     [003]    30.102372: call_function_single_entry: ve=
ctor=3D251
            <idle>-0     [003]    30.102372: call_function_single_exit: vec=
tor=3D251


  CPU 0 is empty
  CPU 1 is empty
  CPU 2 is empty
  cpus=3D4
          <idle>-0     [003]  1067.718304: call_function_single_entry: vect=
or=3D251
          <idle>-0     [003]  1067.718309: call_function_single_exit: vecto=
r=3D251

and that behaves the same as

  trace-cmd record -e 'call_function*' -f 'CPU =3D=3D 3' hackbench

