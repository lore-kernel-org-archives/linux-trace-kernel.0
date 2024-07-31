Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F89A1BD01D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446702; cv=none; b=TFCTndopQzrRGCSyzW05tDzbXGudFZA+0B6Xj1O3A5zY9SH8bwnisZF4SCfVcalgSruDfDgL2aWICZJ6L11Q54j5nbH+F9dNc3yfTLCR/W+xjBEYlqkdD/qjw0BixbIWFlfwm/7pfamoiBZJkMnIxgi2vOAtsuqPFTQxQGu6XfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446702; c=relaxed/simple;
	bh=iQu9CEXuLc6l42Svgzj+WtxBlKFzFHW7zLfsoyk92/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eD8X/95TKR8bankjXmKeLCtfCIwSFITkbPeIDlu/MAusLz+LpRlwPjhcLV7S+Kszq9IgqBFF69x0TDo35U6ZYJcVMTf4fLOW8rZeUzVxXpycIfN+KtvHukhEBw+35nll68b7CknScEh0DPp11P1Aov1lmZz8MIdxIKJQCPburUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YV3omJab; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YV3omJab"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722446700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQu9CEXuLc6l42Svgzj+WtxBlKFzFHW7zLfsoyk92/s=;
	b=YV3omJabzkygD6w1srmMVXbgkkMy6FgAPiFNlEISNTxQ2tg01Ej6MDkw33UtNQ67thLyuy
	wsPyzlnqzXIyTY4C/LsKyPrMuEKKq6YTbZ7a2FTPODeW8Vw2/B27hZTgAt7znwz3hcdOEr
	gCCV+VFCrvtVn068cu4snk5guB9phvY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-7QYG4-FLMGiqndV50fVrmw-1; Wed,
 31 Jul 2024 13:24:56 -0400
X-MC-Unique: 7QYG4-FLMGiqndV50fVrmw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDA9A1944B2A;
	Wed, 31 Jul 2024 17:24:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DFFF1300018D;
	Wed, 31 Jul 2024 17:24:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 31 Jul 2024 19:24:53 +0200 (CEST)
Date: Wed, 31 Jul 2024 19:24:48 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, andrii@kernel.org,
	mhiramat@kernel.org, jolsa@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] uprobes: make uprobe_register() return struct
 uprobe *
Message-ID: <20240731172448.GB2752@redhat.com>
References: <20240729134444.GA12293@redhat.com>
 <20240729134535.GA12332@redhat.com>
 <CAEf4Bza1_njsVUad8so9EFxy8VmJsTfzaaAahBYFtOqdF1HAjA@mail.gmail.com>
 <20240731165614.GI33588@noisy.programming.kicks-ass.net>
 <CAEf4BzZXze8wRQwEJSy5nFzH=uk4wZPHY-gWw6j7iZfeBEiO0g@mail.gmail.com>
 <20240731170551.GK33588@noisy.programming.kicks-ass.net>
 <CAEf4BzYTMTNoGbL6keMhj4hRty-tw5XDeiLHOXMJxRyxZv6Efg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYTMTNoGbL6keMhj4hRty-tw5XDeiLHOXMJxRyxZv6Efg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07/31, Andrii Nakryiko wrote:
>
> My expectation was that Oleg will
> just incorporate that by hand and will send the final v4 patch set.

Will do tomorrow, thanks.

Oleg.

