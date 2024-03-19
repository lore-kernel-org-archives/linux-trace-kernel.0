Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF488446C8
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Mar 2024 05:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827405; cv=none; b=UNvLv1VyofKgmdWKD4mAQLL5SqwqQx2xjyUb4swDJX6S58v70oWwJnOPV+mzDce14GdJKGuOa/ulJQq+p/xH69aCW7zzehzm0aKHgpp0gLzgHjP7m1l1tmVcYBSvxDbq/s6KQMzHs/jCxyOD/SasNxmg5vkDKvlZ8Jd1/Ffa5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827405; c=relaxed/simple;
	bh=d1vQtOKcuqHvKy4//qYVKUxTKEg/z7zK/5/AUEV34Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpOyJUWjP1cJJ+Um/gK5UIIQtFAA9kwuWZ54TOUE6cAZb1gYxSW/gua/0r4UVXFFBONWlbMVjMz2kUT5R/52l1kze+vXLUJSU0fcs8kqG+zZxh87p+kJjDUH8O7bfWSHMkbBIMNEncW/ZRvhN6LiLlfhkrEYyQHI3iJ07h2VJTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnwLIFkX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnwLIFkX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710827402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=905zz3+qAgtGYA95TFFZeQGypKJrD7b7ryqBKkxZsf0=;
	b=AnwLIFkXgO6sXMSZ9G28hosbEBIiuLoUH1K0w7FcM5K+iTrebIuQo4fDuExli3s9/IYjDS
	KP6S+3V8vtcrOui8+Db/XKaypIvngK32dKpHThMP/6hetpUVkP86kYB5r31WtVTtcQHIe4
	PUwvqY+ewSXdnlRCVGCQntgaZTxAdLc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-kmmv7S9POOydRLMIxWd24g-1; Tue,
 19 Mar 2024 01:49:57 -0400
X-MC-Unique: kmmv7S9POOydRLMIxWd24g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A5FC1C06500;
	Tue, 19 Mar 2024 05:49:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.50])
	by smtp.corp.redhat.com (Postfix) with SMTP id 552393C20;
	Tue, 19 Mar 2024 05:49:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 19 Mar 2024 06:48:35 +0100 (CET)
Date: Tue, 19 Mar 2024 06:48:12 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	jolsa@kernel.org
Subject: Re: [PATCH v2 0/3] uprobes: two common case speed ups
Message-ID: <20240319054811.GA20287@redhat.com>
References: <20240318181728.2795838-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318181728.2795838-1-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 03/18, Andrii Nakryiko wrote:
>
> Andrii Nakryiko (3):
>   uprobes: encapsulate preparation of uprobe args buffer
>   uprobes: prepare uprobe args buffer lazily
>   uprobes: add speculative lockless system-wide uprobe filter check
>
>  kernel/trace/trace_uprobe.c | 103 +++++++++++++++++++++---------------
>  1 file changed, 59 insertions(+), 44 deletions(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

