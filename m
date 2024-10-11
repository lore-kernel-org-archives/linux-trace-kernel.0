Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8252C1CB523
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Oct 2024 05:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728622912; cv=none; b=qm9dBdg6koqZ8q3esUavQogzQD9D5VUb4Bzz5wrTLPvRb3NynwUU3bd9pdCnlXVqZlKohHjUdolh6HwNPdDm2b6e/eQnZOZ+tXhvgmeHSQC8qVKoNHcNCCYj6hwMSPlVcWFsijvR2Kth7x7k89+yvj402GgLbJKufd9zFIuDeXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728622912; c=relaxed/simple;
	bh=exQ8VvyzKI3lS9s1FDqMH64r3sebs6IOpR2HqGuZ/DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koBNAJjvJaFGFKi0UmdeLR8o3dlpDyb/n19Lw/hsIlq3No/Y4ctDybT8TxnYU9vfnwLeDdIBSemqOrH6kMQTmrMxB6XD/tPpyr/WN4vvkEuWGINhGeirMeqtHdW8vGY7091ppJRnX9n/B3w2WRrYiihL4ml205dFHnYTZYXUoH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ddhBSojY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddhBSojY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728622910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D/zV6+yqxGlRf1NDbROK0wSHZXpgTfu+TnSkzRD6LcM=;
	b=ddhBSojY3fPBAkQjrcTTv4fOZJD7xkPFc4SVIq87jrt77yFdcInQ2E/4/PhfF9oQHQJTuV
	x+tSGfJ8RGs6wx4k2obD6bi91j9/13xItbIjEkaJCsmzeWLQZkbFC9DrDztum7Wa79y7Or
	FqTez5Ldyh6t76QIBr3erAqvOeTNlN0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-etmiZfrIOKed5xSDbKaqXw-1; Fri,
 11 Oct 2024 01:01:44 -0400
X-MC-Unique: etmiZfrIOKed5xSDbKaqXw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 452221955D45;
	Fri, 11 Oct 2024 05:01:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.109])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B20381956052;
	Fri, 11 Oct 2024 05:01:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 11 Oct 2024 07:01:21 +0200 (CEST)
Date: Fri, 11 Oct 2024 07:01:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org, willy@infradead.org, surenb@google.com,
	akpm@linux-foundation.org, mjguzik@gmail.com, brauner@kernel.org,
	jannh@google.com, mhocko@kernel.org, vbabka@suse.cz,
	shakeel.butt@linux.dev, hannes@cmpxchg.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com
Subject: Re: [PATCH v3 tip/perf/core 4/4] uprobes: add speculative lockless
 VMA-to-inode-to-uprobe resolution
Message-ID: <20241011050110.GD21908@redhat.com>
References: <20241010205644.3831427-1-andrii@kernel.org>
 <20241010205644.3831427-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010205644.3831427-5-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/10, Andrii Nakryiko wrote:
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/events/uprobes.c | 50 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)

FWIW,

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

