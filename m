Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7AC2253EC
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877969; cv=none; b=c9oYiIaQx4J9kPro1ztTqYGwRoQhflAgp8a7DeOq7IpGsbZ/88Tzj3x7vwfB3UKdHaP0W+Xp8DzbekYtl/awNu54VwxuOOktiQfgpPpTMFThN9Fmf7Wf9ammtMSpwpZdBHJpC0ALuVg2Bjr5pdpGZc9Uq+wt57Rcwhg6WW9vEX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877969; c=relaxed/simple;
	bh=8jiqxKcTQFnXGxn3hNE6OwU4CsdOECgb7lkMtk00LGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bi18l/268p4OOZcn0ZzdVslnGZC0XOMjkVBjd6FtU1SP7UF3l7okVBH3XkYqoc6mUuOA5S5MYBvFL0Z7qUNbU+dgJXKIzoXwfOL7IvgAyMopSD1dj9pwFwHfI/GUuSHYfHp3xanXEQNbqg9oKapFIKID1cJP3fFPZqZWjs3FeKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dISNGYsW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dISNGYsW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755877967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mYRySiryXy1ygKi86fAgkp72E4RJ1lkZ+6KjdD+UoBA=;
	b=dISNGYsWb3fI903BInmHhYP33xfVjaIWE2MUptI+99HifQiBugWkcaBwktJWbZk5INciVD
	FootRYzZr2gdSoNx1iqM9lbpwqKsQ2cpidKogICfitTNtEE3Yb4q7GaDXrdKObevw4q/kT
	/jtod/VgIa/cqNeGMoQVg72qyShElvc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-GIJgJcYWMtGJh7-xXoNtFA-1; Fri,
 22 Aug 2025 11:52:41 -0400
X-MC-Unique: GIJgJcYWMtGJh7-xXoNtFA-1
X-Mimecast-MFC-AGG-ID: GIJgJcYWMtGJh7-xXoNtFA_1755877959
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BDBE1956096;
	Fri, 22 Aug 2025 15:52:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.227])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 06D6B1800296;
	Fri, 22 Aug 2025 15:52:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 22 Aug 2025 17:51:18 +0200 (CEST)
Date: Fri, 22 Aug 2025 17:51:05 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: jolsa@kernel.org, andrii@kernel.org, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, alx@kernel.org, eyal.birger@gmail.com,
	kees@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	haoluo@google.com, rostedt@goodmis.org, alan.maguire@oracle.com,
	David.Laight@ACULAB.COM, thomas@t-8ch.de, mingo@kernel.org,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH 0/6] uprobes/x86: Cleanups and fixes
Message-ID: <20250822155104.GA32136@redhat.com>
References: <20250821122822.671515652@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821122822.671515652@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/21, Peter Zijlstra wrote:
>
> These are cleanups and fixes that I applied on top of Jiri's patches:
>
>   https://lkml.kernel.org/r/20250720112133.244369-1-jolsa@kernel.org

Can't review 4/6 due to the lack of knowledge.

Other changes look good to me, FWIW

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

