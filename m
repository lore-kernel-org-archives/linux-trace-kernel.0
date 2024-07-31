Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02701A76CF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411877; cv=none; b=QREqLknOB7Z3ADiz6BnnJnFyAnAdhfv/1OYcwK5Oj5efm+jWPJMUYXgqDsrQZwGTPa4sQdfjI6bEwz+wIW6B+FH0EulhNCfctXZu+mSzgtHwFkw2QZR19CsJHvxSj4Vbfo69bRO6J/lH/zS88VkQhFcVo2UvWK0N0Ba05uG3BTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411877; c=relaxed/simple;
	bh=lxA0ZHyzAHSv0f5PolyU6+qG3+yyZBAlHvqT9SI4L8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjChfZAJjwJHY92ew/LoFBtIrqa94/5IwgagVyHN5xRWm8wFF1T2w8Op2S6vvOYIvmu/kLGAYs6NuPhBsbZchQ3sV9ZIaVWdK/x3R3XcRQ4ksEIgieK4HuJwyjnYEzDkLCF6oNkcQDUlwUpTRF/2K8XfSSRaO0Kzn2V/0ISK02o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MYBLEYWi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYBLEYWi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722411874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l33ddJooolI2Iwh+l//qHtEKVUiYFMImLADxdtqqUrY=;
	b=MYBLEYWi6av/lZx9tW0ak6DMY756WLEGjqU41GDTAbvomedL1p4oCDtrLth3GEoRYfvWVd
	D9w8MBTi0x28+f8en83XT9qhk47JEdidUuWXX1ao/6IqoAhwDwd3xts4mbFtAr21Bfcls6
	jUZyZ7eB8lRAZoyMRa7oq8IDNBKdOug=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-7W_iWS86PH2he35fSQSWzw-1; Wed,
 31 Jul 2024 03:44:31 -0400
X-MC-Unique: 7W_iWS86PH2he35fSQSWzw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C3641955F40;
	Wed, 31 Jul 2024 07:44:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.143])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4DD921955D42;
	Wed, 31 Jul 2024 07:44:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 31 Jul 2024 09:44:28 +0200 (CEST)
Date: Wed, 31 Jul 2024 09:44:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: andrii@kernel.org, peterz@infradead.org, jolsa@kernel.org,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] uprobes: make uprobe_register() return struct
 uprobe *
Message-ID: <20240731074424.GA12813@redhat.com>
References: <20240729134444.GA12293@redhat.com>
 <20240729134535.GA12332@redhat.com>
 <20240731143946.f5689502e03b9ff2e79be494@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731143946.f5689502e03b9ff2e79be494@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/31, Masami Hiramatsu wrote:
>
> On Mon, 29 Jul 2024 15:45:35 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > This way uprobe_unregister() and uprobe_apply() can use "struct uprobe *"
> > rather than inode + offset. This simplifies the code and allows to avoid
> > the unnecessary find_uprobe() + put_uprobe() in these functions.
> >
> > TODO: uprobe_unregister() still needs get_uprobe/put_uprobe to ensure that
> > this uprobe can't be freed before up_write(&uprobe->register_rwsem).
>
> Is this TODO item, or just a note? At this moment, this is natural
> to use get_uprobe() to protect uprobe itself.

3/3 from the next series removes the extra get_uprobe() + put_uprobe().

Initially the change said something like

	This patch adds the additional get_uprobe/put_uprobe into _register,
	the next patch will remove this.

But then decided to split this "next" patch and send it in another series.

Thanks,

Oleg.

