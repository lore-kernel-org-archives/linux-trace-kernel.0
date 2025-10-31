Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07BF241679
	for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918554; cv=none; b=kzt9tYME9jGRHwl1TEyWv+WfZxqmmtT613E8TNxOsu+L9ZNRNbv+9/nNPNAclen9bKrBSAx/ddTCmKhG2kSOPUX8F3tkngMJic+clhbWm/udhyE62OLlgDdpOag2krSM9AbCf0xN8l7B+hnszLHxKZ5TsGLm6LXktSkfzlLKlPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918554; c=relaxed/simple;
	bh=otBBx4wfl85EDYap2Atk5K5Z77gwvTZrcdqKjrD7Hz4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oaa8zMrFVIqaoQF6eewcBU423hKjk38LxiGYKMNNHQP1ESUL5FcB36Qf322jgRPWZL1T5eznU6mw+eicBvrZ5al0snMFFmwjm8tLHWk7sx6ds2PtOWiLR9W+poMAfcmy7VnEeQTtvSejBVWmQR7xA9YToU6V13TCK5zuJcxispI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ihczWjKN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihczWjKN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761918551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otBBx4wfl85EDYap2Atk5K5Z77gwvTZrcdqKjrD7Hz4=;
	b=ihczWjKNiFmNjlwfAwPElxjjAunTWjpo2PjnC/X9ftJEcBfqQqo/A6lAHTLD+u+nu+4di0
	wobj8VZ7oPmfx/V+UKhbOYsfKHB7iZsblTrnvMLjYv2ya3ZzXqWTz1NquJLkBzB6fxNe9W
	Xo7eYR5Yz+A9pxJDIlHQXXJ8qUvuVN8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-D9O5KLcSN9exZ4F3u6oUWw-1; Fri, 31 Oct 2025 09:49:10 -0400
X-MC-Unique: D9O5KLcSN9exZ4F3u6oUWw-1
X-Mimecast-MFC-AGG-ID: D9O5KLcSN9exZ4F3u6oUWw_1761918550
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88041f9e686so5786516d6.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761918550; x=1762523350;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=otBBx4wfl85EDYap2Atk5K5Z77gwvTZrcdqKjrD7Hz4=;
        b=lJ6qm9ZqHWnhZxdYBG9MlztbDlrLRJSODQ74V1kmqAZJ2H7iLQEpLdTBAOw5OaILhQ
         BM51U7GjI8KaGkFLsVM2lcs6irGzjaIWlcQhoz9eJbytirfVHd8wcXe2Wl5vVTH/tNJd
         UpHq0kpK6U2huRfSv2MGslWYbGS9CsxU9BZAlll5SX7IC+2/iirlCeCxndylQKl7qjXA
         zeM79DaW7c4DWZV4GxEvcrjkFtBVANAS400Llqy//IXEyly/DeBzWPaeV+zh8TW+4paW
         8hhvQN8+e6ijAQsPn25r0kmAbpibQZurlVV8tgoQDy+eD3bCnvmRVxDlbm3Pb6JwY5N0
         SfTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVniO0hidIC3WQHoiHnD769JvQxP1zPdOrJ4coSY3TTTGpxMBfqGpIEfWHDvUTIT677T62bxyYjGOTXt/qO3FyObSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr2DNhmxOMfnt78N2J1cUNSw7h0U7h6TJLEhrPHsSB9G4x6oXf
	6T0tvKNCwCfNh2XqqaAuVJdN/7lBFWB7ebrsAtbo0TLmGekz7GsTVhyjjDLcv1pEILrLPqd1aHh
	XTs2aSIqBESvuGEs96EMhcQ+8AiSuehYQnWZqReNZB8thuDVOQmxbn9nfPSsz9m/R4QV89gXaFA
	==
X-Gm-Gg: ASbGncucvrMUPFfhsuUH0n2J6hDYQT6V/syF23FOEdhQTJXhFkF9UCKemVPHABbOvCR
	P24ZMppQYuVR3wAaSYM8e6dd7DDUHOzCdwtV2Et7bU7qF4exhMkUEaUwEJT5kwMDJtSmngC9gDR
	ozR0XiaawDtg/zOlELeq9xyRE5WIhN2YDf4eaQLfyXcUUOb9VOCMsmd2+XL4AI+O6FGZtxN+tgs
	heAhgAYb+ePgMv93J5TSkrIspmDVOxGIYW+//IG4fSFl95n2vpRd1WaRgWIm0RAW6uDVhGXCZGT
	cz3upnxj8DKB5CftuFXDaClbDHfzdYMgaZ56Bnrbe6w2MgDSIUKlbIWxgtj4fqJfjXOixEQ6Hwx
	pS9Y1dtTK/7yu+CD+B8JJc5Flk0bqRGPCqRh7zvb23HK2QihNSZO0tAeOlrF9n7Wz
X-Received: by 2002:a05:6214:29c8:b0:87c:67a:ca69 with SMTP id 6a1803df08f44-8802f521df4mr38809446d6.61.1761918549838;
        Fri, 31 Oct 2025 06:49:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMIRsRVAV5K6QvCw1eHulx31J7vhSYenLFXxOs2TXmvIp5Ub3MJu5pl3+ly4k6nuAEmbzZzg==
X-Received: by 2002:a05:6214:29c8:b0:87c:67a:ca69 with SMTP id 6a1803df08f44-8802f521df4mr38809106d6.61.1761918549454;
        Fri, 31 Oct 2025 06:49:09 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (syn-050-074-019-099.biz.spectrum.com. [50.74.19.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880360ffca8sm11630206d6.27.2025.10.31.06.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:49:09 -0700 (PDT)
Message-ID: <a0e34d41214dd6d98e3c7b7ec37be7ad0e1812e0.camel@redhat.com>
Subject: Re: [PATCH v3 0/7] rtla/timerlat: Add --bpf-action option
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel	
 <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa	 <wander@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>
Date: Fri, 31 Oct 2025 09:49:08 -0400
In-Reply-To: <20251027153401.1039217-1-tglozar@redhat.com>
References: <20251027153401.1039217-1-tglozar@redhat.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1WiE1ujb929icTXrtRkHtidnFL9imLxoKx2f0MaPtxo_1761918550
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-10-27 at 16:33 +0100, Tomas Glozar wrote:
> This patchset extends rtla-timerlat's BPF support with the option of
> executing a user-supplied BPF program on latency threshold overflow.
>=20
> See the supplied example and documentation for how to create a program.
> bpf_tail_call() is used to chain the program with the built-in BPF
> sample collection program, if the threshold is hit.
>=20
> The feature can be used for both in-kernel data collection and sending
> signals to userspace directly from the kernel, if the kernel version
> allows it.
>=20
> Note: The patchset will have to be rebased on top of [1], or vice versa,
> since they both touch stop_tracing() ([1] adds one call of it, and this
> patchset adds an extra argument to it).

Probably best to add an updated version of that patch to this patchset.


> v3 changes:
> - Add tests/bpf/bpf_action_map.c to test commit (forgot to run
> git add before).

Might be nice to build that as part of "all", for the sake of people
running the tests directly (FWIW, I still don't see anything in the
makefile or engine.sh documenting how to satisfy that dependency).

In any case:
Reviewed-by: Crystal Wood <crwood@redhat.com>


-Crystal

