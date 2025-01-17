Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670CE19B5A3
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jan 2025 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737129321; cv=none; b=RfMBRBv+C5wcDIZafzQe4U7UDRnA4Lu1aYUn0tLiEFw4n0xg3v09dPF9KgTubulFEj71iqyddlHMT5/359pIPvWS+qmMT0NYqDedWhjN2Du4BjbiZkUlrrktFD+++xQqhPx1d6XV6ke3u/OMxJFPW06Y04R9rgbjw8hCr2fGXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737129321; c=relaxed/simple;
	bh=ZEJew8uw+VgZhSNf8bku5kGKxIcLXVGIe3fxALoW47E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7gWax7X8WtIP+AE1IJ0/EUpLZRurYQhlvuIiT/4C2o9dNsMoq2inNNAkkQndXeTsOCpUtYRHybOouQMAdaCpIPP8jrlMBsnaJL5eAjMKljdfdAB0UPJI3qDAkE/69n2CZWOrC2T/Xtn19ji7qsMU4JzTPSow6amaHsDxsZhR5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5rpvKd0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5rpvKd0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737129319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEJew8uw+VgZhSNf8bku5kGKxIcLXVGIe3fxALoW47E=;
	b=b5rpvKd0mhoIO0oXEwIhiJGN9++g4lcXUdNyV/m0tsHnc6vzxCl9OVPjXvmMj3rzT5aaY/
	v9/Ms1dayJlM0WdLrt2RKM4v4cYnz7NtcgAsLJYcX2VR5kfdqPXgUSNickA0XsbXbOMXPp
	ytwmdCGyjVwjMf6L0eKedtRVS8FlSoA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-7rLT3LudOlSCWhQlaf3HFw-1; Fri, 17 Jan 2025 10:55:18 -0500
X-MC-Unique: 7rLT3LudOlSCWhQlaf3HFw-1
X-Mimecast-MFC-AGG-ID: 7rLT3LudOlSCWhQlaf3HFw
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa6a831f93cso272900266b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jan 2025 07:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737129317; x=1737734117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEJew8uw+VgZhSNf8bku5kGKxIcLXVGIe3fxALoW47E=;
        b=kdiv/52drMPzFOVT+0lQ1fwewiNx2R3bvSu/53t9Jp7y5QxkgSzAW9XnTJ5ftNZcqh
         L6ax5dCpVuBvVY4DIodHLcCzOzS+bAJ+f2uhZ0o30mRBwIw1XvKmXIFhr6COT4ENjOEy
         3FA9YwX6OfYtZEjxnqC5esCgmMHzApqPw6VdIfNA5tBI2fysJQyZ9UA4ZMAhmvDKbiMu
         0rq193dd+xQlSN97/8Uxtg/VSsu478wH3zVNTB3QM8jRGCkSdVhN5BEu/DR1Xb2l7/iX
         gHr8xXcQXJIXoc+ByNyHFwbMBn7DZHaiEcZ2HpWzLauQBwprsikrySpBqCoXvIdzAsgv
         dmCQ==
X-Gm-Message-State: AOJu0YxFH4y8ichW55VE9nFi0EZ5GWaSLis7WxAqKS16yOblopdOEflA
	j9WoFshOqoUcoEQ3dv0iaEm6z3dSAR7Bsreua4dHKopmOXm9HT4RS2zM2Cvijmvw9E7flBROeCb
	UIkdD45YUxsJbux5NYBEFYgKFx1ndsDjAcNPAMStuui7IbDNe4THbqXKLZLwD/d1Y6swjpUoopM
	EwGPHM/bslnqYJtXpBJqdWqDikHM1lO03tG8kJxxdDPbi+Ri3YCA2NCC8u1A==
X-Gm-Gg: ASbGncv3kMS7YW44Vg21ouxsxeAqiTvL7BgBV+6t6JDTD4KTbg9o9mKxslwT16Lic/O
	2Apw7BkQnBmYjP7s6Fyp5Z+rxAZcPez5c/DkmyybjeCv0Wla7I/Y75CRKPv3bMb7lvgSdBA==
X-Received: by 2002:a17:907:971a:b0:aa6:66eb:9c06 with SMTP id a640c23a62f3a-ab38b1e207bmr288712266b.5.1737129316728;
        Fri, 17 Jan 2025 07:55:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYYV2Wi77CNQb8NfEM/mbB0BDKmjLbqjnKNw/jaQf4PwBug92JFBVhT6R72SsCk279qL92Cm/MbJdrfBCAJ9U=
X-Received: by 2002:a17:907:971a:b0:aa6:66eb:9c06 with SMTP id
 a640c23a62f3a-ab38b1e207bmr288710266b.5.1737129316401; Fri, 17 Jan 2025
 07:55:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116144931.649593-1-tglozar@redhat.com> <20250116194621.7b309aed@gandalf.local.home>
 <CAP4=nvQpS20ubNspE0PPhiyWb3-ARV=gmQzFCA7WwAT8+rxMjg@mail.gmail.com> <20250117102924.690cb7c7@gandalf.local.home>
In-Reply-To: <20250117102924.690cb7c7@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 17 Jan 2025 16:55:04 +0100
X-Gm-Features: AbW1kvaRXBg2PVPa6dU9bLx4cAfiEKNYL7QcMpEifxHRTeA41l3SHXPwJ2Y4C-A
Message-ID: <CAP4=nvTfJzG=zSETao_ukAQUSVrjZeRTw1+OEMg_LNJqdW11jQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] rtla/timerlat: Stop on signal properly when overloaded
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Gabriele Monaco <gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Eqk-c29wZuvzmMKeDGpZJ7YtHH_FZjlhbjzqe8VDbJM_1737129317
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 17. 1. 2025 v 16:29 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis=
.org> napsal:
> Hmm, the timerlat event could probably get access to a trigger to allow i=
t
> to do the work in the kernel like what the 'hist' triggers do. We can
> extend on that.
>

If we only need to count the numbers, that would be a perfect
solution: use the hist trigger in place of the BPF program (no need to
reinvent the wheel!). I'll have to look at exactly what we need.

> The reason I haven't written a BPF program yet, is because when I feel
> there's a useful operation that can be done, I just extend ftrace to do i=
t
> ;-)

I used to work with BPF, so I usually think of a BPF solution first,
then I think about whether I can replace the BPF part :D

Tomas

