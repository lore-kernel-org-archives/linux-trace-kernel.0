Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C73188CC8
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111493; cv=none; b=jd6ubX2ahprh64o+/28uTpgPzqq/HrzhF7JxKyjg2dMp153V+KyuWpQgFVOo4cVbIPjXAhc1Cx7/FSQO7/wtEyOkDrqwzAUOm2NRb8E0TXECyHYDB+EkfsplEdhPpo5RFKyW53/i+hFeBUeCaCcyzddpVKj/VvxHdTD4YPfzDA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111493; c=relaxed/simple;
	bh=o0/CJsAYa37DbqjLPygfmosP/qEF/V5TS9+ofW5zJbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9fWDLAfw4BTVMQqdkQQ9W8vJC5h2aOjE4I4HrrZcJ3jREjuGaKicQ6MWHP3N6E+SOkH+fdYb75YO5/pdyH28Qkne3r3QCSdtExjBAcfUMuUcYWEEqRbNwIeT/7g7QAD2B2RD2mXuNjwVJ94UmPsaPmaIBoWkzvwpNKcsWRmPMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGL27TVO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGL27TVO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723111490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o0/CJsAYa37DbqjLPygfmosP/qEF/V5TS9+ofW5zJbo=;
	b=YGL27TVOhiXEHGIV4QW3K0di56MFS3qvWX0GKxMtEzEsHJjDshoZCD9YP32wnZvrDiFeSo
	jjolrVDrxBSE8FapBwwUqDlGMuuY0w4MYgjEtMXiUITntWSHcjAXfbZxbO6Uwta0ac2G+S
	wpvjhwIY+OLG6ai7cAAoBwVl/OSK9t0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-lJcWYmbyOvqVRxuWgvtQOw-1; Thu,
 08 Aug 2024 06:04:47 -0400
X-MC-Unique: lJcWYmbyOvqVRxuWgvtQOw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D1D91944D39;
	Thu,  8 Aug 2024 10:04:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 718431956052;
	Thu,  8 Aug 2024 10:04:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  8 Aug 2024 12:04:43 +0200 (CEST)
Date: Thu, 8 Aug 2024 12:04:38 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org
Subject: Re: [PATCH 7/8] uprobes: perform lockless SRCU-protected
 uprobes_tree lookup
Message-ID: <20240808100438.GA8020@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-8-andrii@kernel.org>
 <CAEf4BzYbXzt7RXB962OLEd3xoQcPfT1MFw5JcHSmRzPx-Etm_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYbXzt7RXB962OLEd3xoQcPfT1MFw5JcHSmRzPx-Etm_A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/07, Andrii Nakryiko wrote:
>
> Ok, so it seems like rb_find_rcu() and rb_find_add_rcu() are not
> enough or are buggy. I managed to more or less reliably start
> reproducing a crash, which was bisected to exactly this change. My
> wild guess is that we'd need an rb_erase_rcu() variant or something,

And then I think it is not safe to put uprobe->rb_node and uprobe->rcu
in the union, sorry...

Did you get the crash with this change?

Oleg.

