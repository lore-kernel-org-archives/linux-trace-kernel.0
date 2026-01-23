Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6120427AC41
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769173242; cv=none; b=e8nTlYb5HLuzn/oavGGom81ViAhWPGteDMRI/ACeJBgktywROMfQm4FdSJJmwjawRY2fdQdcqtobBedIajGn6UjTwrnkznr9o2l0uX2DsRfVhyBt+giCmpJx+UjyWFBltT0Hv1mVBiDUr5gJy/YN+6CyDo5hSkEPCOLUDgX5QQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769173242; c=relaxed/simple;
	bh=Q5KxkvBw45kLMEwkjsxOo30JWAV7DYfubSP6bNhJYxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=I34/czGO7AQkGCJ9gE9DJPMR6mn80S2hcpxao2xrXCod3BBKZJA/dKqebkUlpiGmLeIXkcImTcKFVS71ZNW5UVxnXkB1ncVWiWSsoYg/EgaPq8LSICrE83Y8yJx2F3OH4CO0+0DHzp4Gc4xwbWe2iEFO4b+X9QEWhHhDqmyVBRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VylE5X9M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VylE5X9M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769173240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xhZje8lDK99qvbA67IbRnofBmqhSmN/zFTweUwOVMdI=;
	b=VylE5X9MczXHXx3gu7wfrulPBC4LLPszrYFMlOXafeZ9zQc+cVa9eNj+5YLcbrOG+np7hw
	PNFSPu8dVg4hOM645UKmbXbzmjzwRN+j1nVw7iNoeq43CxPPBLUx+5mQSx0s0dIbMxtkLL
	QeGFm2exqqxmMyvQSU/G1b10i7hRUEs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-nKws7HiGPia6i3Tcxhw1Wg-1; Fri, 23 Jan 2026 08:00:39 -0500
X-MC-Unique: nKws7HiGPia6i3Tcxhw1Wg-1
X-Mimecast-MFC-AGG-ID: nKws7HiGPia6i3Tcxhw1Wg_1769173238
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47ee1fe7b24so20061925e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 05:00:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769173238; x=1769778038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhZje8lDK99qvbA67IbRnofBmqhSmN/zFTweUwOVMdI=;
        b=cCW25+ppyJoByAcgysTLwdCdQCfax9PU+Y4GK1vxSebw5mSATFBqKn6SJXqth24bvr
         2VPfjM178CMtVjXjxJEOCa9aWgC9yayhNKoVgOlpFCTeJD7nje2v2LhTPBK4xpffhnPT
         Mhs4J1oQdCGwe3qGaUA2+OK5FEv3UqAOWtQUP4fao4hIoOiVwu3Vo9COH2zlgaBi5GcC
         EWjPYwesfOgWrT3ar/e1pRqOC/z7ohZCIj3i2sipiJ8hVIbTYLg3qs0qOGafS/H/L4PK
         8w0ccd7ehoYz/O6UflAkNmsdQmDgU+bJsCWZy73qiaag5E0yalKXO0HXPZqgff6eAAkL
         YfQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxgiAjj1iPkfLw+zeaD2uCTdm466NsDgbGbnYwa8dEiXl66P0pPzMK59txx+6F2r432hNsFKN15Q9azBMKDjVC5Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzltmYaXwLWNuu8t2FZ9cy5tZMCEFAPdh8lNTLVE7lGUtHR9jFH
	f6ByeMf8teDqV8RYpJx7+wwv8O/51hOmzYcQMQcPxOh4T0C5/GCcUhlc79qmGtsTqSsVog19Np6
	yec4GzJur2RqoyNSJ6xZFPyeuo/SIlNcbBtMWkLaBvfvcdS7ftwjT3RKUVtoxpgW01GzFrvGpHg
	==
X-Gm-Gg: AZuq6aLo0ft1a+h6pfn7QPa39UvoAGVQL7LFoa4QUalLSV5JOrpMk8ytJGyiNaZ2HXi
	Wg5Yy9ooFmZghe4kbzdp1R2K5f5C9UfdERz6KitzrzDUpirqRtIm0Z7Zxh5l4HZlSxueiCDAFGt
	Vf5fpTPlRBb9qUqMlPGv5IdrybdRRkHfy0t520CodthLXdv5ghawLrv4kVCESjAXh2jrzdG5FAU
	Oe3QT2cOnMOmyQ12EmY5FBy3LrJzcBcXm3EEZVT87sznwBlFHeO6/jMlPYzU1CesKBCqLO2IzT7
	/h8+nmDomWc9BK7mqhVFIKez+xnVVm8Pi3Ya2HZa9cs+G4L1aQsd6szvaQL7dj/qNUEdTNVgQT+
	7D7b8FJ42siQnN6gln4pehXAZX5wT3mloj8aoHFJh
X-Received: by 2002:a05:600c:4451:b0:479:1ac2:f9b8 with SMTP id 5b1f17b1804b1-4804c9becf8mr42932485e9.21.1769173237539;
        Fri, 23 Jan 2026 05:00:37 -0800 (PST)
X-Received: by 2002:a05:600c:4451:b0:479:1ac2:f9b8 with SMTP id 5b1f17b1804b1-4804c9becf8mr42931885e9.21.1769173236953;
        Fri, 23 Jan 2026 05:00:36 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48047028928sm199297575e9.2.2026.01.23.05.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 05:00:36 -0800 (PST)
Date: Fri, 23 Jan 2026 14:00:34 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 13/15] sched/deadline: Move some utility functions to
 deadline.h
Message-ID: <aXNw8i5So80W7Uju@jlelli-thinkpadt14gen4.remote.csb>
References: <20260122155500.362683-1-gmonaco@redhat.com>
 <20260122155500.362683-14-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260122155500.362683-14-gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2xCsdE7QTZnk8OovdhXFO26PvsYsVQ20tf7Lm6i98TM_1769173238
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 22/01/26 16:54, Gabriele Monaco wrote:
> Some utility functions on sched_dl_entity can be useful outside of
> deadline.c , for instance for modelling, without relying on raw
> structure fields.
> 
> Move functions like dl_task_of and dl_is_implicit to deadline.h to make
> them available outside.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

