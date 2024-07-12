Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C57155382
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720780096; cv=none; b=LLJhJPHWISziw5Iess6wslqVzcF3u+7XTPOmUZdxRZmNv5ZHgUMrdIkmZ/wTDWMGYlIr+bRlmh8c8GeoGhPRySdRk7gefNks+ZQ5j2G1AlKayo+td/4hvF1jjZvLwIeduI+n9QxK19dSmY0lPLbz8kWwpIB3qklJG58rF4lS9GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720780096; c=relaxed/simple;
	bh=858t69WfL/tj9FR/9VOg/7LQIGZGuDl9bR4EsN6LxjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAJn9oC1YXlLqADttkhqOfoXP7mSKHcXKxpsrX8dR3/p+Uj6YRN5+w+hGTZ4eDTl93k4ZHFZTrHKjfyDoed6uPBiK1dsVKHwIlP4mDJGYdOS4fnK9h2FytPWdHzJbzexEX3dGzSXhaKYDLrvBg7DIA6vdD3ujtAR0AQz35Viktg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/oEJ5tn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/oEJ5tn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720780093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=epE1NcIup0vbrzaXG/uxhpSJU7vRRm4fO7gG8wrP94c=;
	b=e/oEJ5tnql0KfceZeZc7VZoM4rWx8VRAzWPOvkHmniTl+AWF3VCS6ion8kUsCyMX1mllZk
	OhkVA8y+VXq1gY3Ech2chyeFzTEEFm8bkodMnesV2ohpJpaQo21+6GbEXAtbPeQMp3fewS
	o11gG1vtzETuWNpAtAB0icicyvrFWLg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-FpBauZnNNbie9WNCv3t6PA-1; Fri,
 12 Jul 2024 06:28:12 -0400
X-MC-Unique: FpBauZnNNbie9WNCv3t6PA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 079AE1954B38;
	Fri, 12 Jul 2024 10:28:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.173])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6910119560AA;
	Fri, 12 Jul 2024 10:28:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 12 Jul 2024 12:26:32 +0200 (CEST)
Date: Fri, 12 Jul 2024 12:26:27 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com,
	paulmck@kernel.org
Subject: Re: [PATCH v2 10/11] perf/uprobe: Convert single-step and uretprobe
 to SRCU
Message-ID: <20240712102627.GA31100@redhat.com>
References: <20240711110235.098009979@infradead.org>
 <20240711110401.311168524@infradead.org>
 <20240711160652.GE16902@redhat.com>
 <20240711184251.GD27299@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711184251.GD27299@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 07/11, Peter Zijlstra wrote:
>
>   uprobe_free_stage1
>     call_srcu(&uretprobe_srcu, &uprobe->rcu, uprobe_free_stage2);
>
>   put_uprobe()
>     if (refcount_dec_and_test)
>       call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_free_stage1);
>
>
> So my thinking was since we take uretprobe_srcu *inside* uprobe_srcu,

Ah, indeed! Somehow misread the change in put_uprobe() as if it
uses call_rcu(uretprobe_srcu).

Thanks,

Oleg.

