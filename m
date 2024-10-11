Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C38519146E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659386; cv=none; b=eOjjXr6nKxgdmgy47Imk6b7/CdnwWZ5yUrKWkKVm9n6TfOIbXoN1GdrD51DIb5Yw1NyoqtZMMMi5eXvZVPFFMCeeh+6Gja7BJm8Zg9hnhH/CdtDY4e0TITmfrxWPg54ExgIshpEgmOaliawWPX8pML3dnBk/o4I/qLP7vkrpGxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659386; c=relaxed/simple;
	bh=+pffSBIZA+a8CSVgLMTRKdxIGcssG/c8mbcHlhem/rI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FkKHL70IiX2A70KfMaNikpZ8Ex7uvrbW05OCIW6SkjytUGm77yjbKI4wgUklH+l73M9Kh1dBD/QEcyy/TUdrD+pEO7gaPzfBCC/gZUVFy5LHwTA0QlFQn2H6OEJ9zS7bCsgxWunmFJVvlh8oW6oSnlXhX0au3ptdDlJVWx+771A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsSQ09k2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsSQ09k2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728659383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7AyAkq/LD6360rwLpOZDql6SR1jmHq2j/yk3NQnqtQ=;
	b=SsSQ09k2qwaES2cVlFBvrd2VTtR+1PgtzkTZErk1SoxGQ46hRYhH8SJ1Iw15QMkMnz67u7
	LoXGiRK9/avikUm4my/GgBSTOdk8WFEuOX5d94jompPGwrD9eZ7ILFfkrpEPUGxnmhSAH1
	9LdPJ0oiZPPRvezNXa86y4L1icCxtUY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-zBGQrGkCO7yqwie6p-b4rw-1; Fri, 11 Oct 2024 11:09:42 -0400
X-MC-Unique: zBGQrGkCO7yqwie6p-b4rw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b111bc482eso440401485a.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728659381; x=1729264181;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7AyAkq/LD6360rwLpOZDql6SR1jmHq2j/yk3NQnqtQ=;
        b=Byb4B8dcDYleNCskKfeeeRW3uEeB7GVnPRutV4I22JGiFbRYLZ4nLjJuPL7qu/KHk2
         M9yp4AICqVplx8YU59M2I+UXd69Nb278BG5p7dQJvQmg/UFTF0+BaxxWs3e6DbCk/BKG
         +CQLOdabXHLNBRWr4TSX4F9BeCGm8P6tFurXLauZMBzdo0GPuXpwqbgG9wZjw8vXgk9J
         F/qw3/wRqG5pknwoLMfopVPGzxnKGzA9o2cXwxoeXPvPJ9JSonlFUUCCRexhj6vPa/s2
         NMWJm3EG/HKDQTXvnNMIQH12knTt/NDbmwmtxrz/YD/IB3cK9wUtKfS6/FEGwiHF3FI2
         D0Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWh8dhI4Ut7wYxpQ2yt8Knfr3xT+WCXzsLixLliztCs8tEZ320t9T4418TAdlb4QLnlddi4ZORohZnoCjZZ4l2+QQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZtnBmN09G66UqD+JO3fzMyBGHxm5FZ/E5GsG00IF/e5ukgahh
	FZG/ADyQVi9JvLyguHpeqogS11hFw0nOCkPteEd6AHN+v6rX+68ETyABGLYx1SZ9il3bOWHxu2w
	VBE8qrn0/STLj3F8cFfqtoIaeQqj75iBDKtDcFpX/oHXMP8mEnuCWj2aKkBJ0LWh9mwuvQA==
X-Received: by 2002:a05:620a:4556:b0:7a9:bad0:4572 with SMTP id af79cd13be357-7b1124cb767mr1240065985a.17.1728659381198;
        Fri, 11 Oct 2024 08:09:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEphbyV5tig9Nw95QtLJTUGp11LFAs48h1xyWPDR/B8YigrZvhaCucr/272XMaK38i4e2X6LQ==
X-Received: by 2002:a05:620a:4556:b0:7a9:bad0:4572 with SMTP id af79cd13be357-7b1124cb767mr1240060785a.17.1728659380839;
        Fri, 11 Oct 2024 08:09:40 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b114956044sm139874785a.79.2024.10.11.08.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:09:40 -0700 (PDT)
Date: Fri, 11 Oct 2024 11:09:39 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, lgoncalv@redhat.com, 
    Attila Fazekas <afazekas@redhat.com>
Subject: Re: [PATCH 1/2] rtla/timerlat: Make timerlat_top_cpu->*_count unsigned
 long long
In-Reply-To: <20241011121015.2868751-1-tglozar@redhat.com>
Message-ID: <f67e508d-5d40-596e-9d98-55b9ce2c8f8e@redhat.com>
References: <20241011121015.2868751-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII



On Fri, 11 Oct 2024, tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> Most fields of struct timerlat_top_cpu are unsigned long long, but the
> fields {irq,thread,user}_count are int (32-bit signed).
> 
> This leads to overflow when tracing on a large number of CPUs for a long
> enough time:
> $ rtla timerlat top -a20 -c 1-127 -d 12h
> ...
>   0 12:00:00   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
> CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
>  1 #43200096  |        0         0         1         2 |        3         2         6        12
> ...
> 127 #43200096  |        0         0         1         2 |        3         2         5        11
> ALL #119144 e4 |                  0         5         4 |                  2        28        16
> 
> The average latency should be 0-1 for IRQ and 5-6 for thread, but is
> reported as 5 and 28, about 4 to 5 times more, due to the count
> overflowing when summed over all CPUs: 43200096 * 127 = 5486412192,
> however, 1191444898 (= 5486412192 mod MAX_INT) is reported instead, as
> seen on the last line of the output, and the averages are thus ~4.6
> times higher than they should be (5486412192 / 1191444898 = ~4.6).
> 
> Fix the issue by changing {irq,thread,user}_count fields to unsigned
> long long, similarly to other fields in struct timerlat_top_cpu and to
> the count variable in timerlat_top_print_sum.
> 
> Reported-by: Attila Fazekas <afazekas@redhat.com>
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/timerlat_top.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
> index 210b0f533534..ee7c291fc9bb 100644
> --- a/tools/tracing/rtla/src/timerlat_top.c
> +++ b/tools/tracing/rtla/src/timerlat_top.c
> @@ -54,9 +54,9 @@ struct timerlat_top_params {
>  };
>  
>  struct timerlat_top_cpu {
> -	int			irq_count;
> -	int			thread_count;
> -	int			user_count;
> +	unsigned long long	irq_count;
> +	unsigned long long	thread_count;
> +	unsigned long long	user_count;
>  
>  	unsigned long long	cur_irq;
>  	unsigned long long	min_irq;
> @@ -280,7 +280,7 @@ static void timerlat_top_print(struct osnoise_tool *top, int cpu)
>  	/*
>  	 * Unless trace is being lost, IRQ counter is always the max.
>  	 */
> -	trace_seq_printf(s, "%3d #%-9d |", cpu, cpu_data->irq_count);
> +	trace_seq_printf(s, "%3d #%-9llu |", cpu, cpu_data->irq_count);
>  
>  	if (!cpu_data->irq_count) {
>  		trace_seq_printf(s, "%s %s %s %s |", no_value, no_value, no_value, no_value);
> -- 
> 2.47.0
> 
> 
> 
Reviewed by: John Kacur <jkacur@redhat.com>
Tested by: John Kacur <jkacur@redhat.com>

