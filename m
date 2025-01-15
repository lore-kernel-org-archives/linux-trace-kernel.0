Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266BA33985
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 00:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736902257; cv=none; b=KyFffJUxcBab8ZM7qitRPlhAFnkpdLF51P7QxQ+Wq7Oqgk2Kdmzkj8Tp6nXz/iECZCCmUeknKwh8Hg08aB1ZkYsLHIKocAgAg44ryiCv9P1vCSWsWd4FoPp1LdW0ntF7Y08YfKU3HuqsqHvNNPn6Pak/HbzQYgQUiWiFoMJeCxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736902257; c=relaxed/simple;
	bh=ExRFbCkC66JXTmR5t4uS0YuvlcT4DV8859zahWbmb3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCAEFvcjC15D30O1Vyz562oA01tTYQtEnbBpHbYRtTdBA8a6xuPTRMY4ACBiSuPjWKSDRrkL5cgBuXZgFdIhUPAt8Up4yC+q8d3Fz8PgJs7XpX7KmoZmVue9doMfKwO6AzOGxs6sOA/w5y6hUTqQxP5zqf9lC/s9O8WRzj/5j8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=beTgrfDv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="beTgrfDv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736902254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ExRFbCkC66JXTmR5t4uS0YuvlcT4DV8859zahWbmb3Q=;
	b=beTgrfDvfE35M4kM4bLaLqV+tw3xGRK7Lf0n9ArqxZigqU5b9woo1T8jz1te9wOTk645SR
	DGdvA3OH8VYx8AAF9GJ3ESMRdWdNLeRlynhx4xlVLVL5Je5MPB0CjbeYgkYmdWidA5655r
	gs8CYgEBgGtJ6AhBZ/Z8M8ja89kedY0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-v-8OZov1Pka9KE66gwYUBg-1; Tue,
 14 Jan 2025 19:50:50 -0500
X-MC-Unique: v-8OZov1Pka9KE66gwYUBg-1
X-Mimecast-MFC-AGG-ID: v-8OZov1Pka9KE66gwYUBg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E664019560A1;
	Wed, 15 Jan 2025 00:50:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5190E19560AA;
	Wed, 15 Jan 2025 00:50:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 15 Jan 2025 01:50:22 +0100 (CET)
Date: Wed, 15 Jan 2025 01:50:13 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, Sarai Aleksa <cyphar@cyphar.com>,
	mhiramat@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org,
	tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
	linux-api@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
	rafi@rbk.io, Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <20250115005012.GA10946@redhat.com>
References: <CAEf4BzZquQBW1DuEmfhUTicoyHOeEpT6FG7VBR-kG35f7Rb5Zw@mail.gmail.com>
 <EBE7D529-5418-4BD6-B9B5-64BE0FBE8569@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EBE7D529-5418-4BD6-B9B5-64BE0FBE8569@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/14, Eyal Birger wrote:
>
> Its software, that’s working fine in previous kernel versions and upon
> upgrade starts creating crashes in other processes.
>
> IMHO demanding that other software (e.g docker) be upgraded in order to
> run on a newer kernel is not what Linux formerly guaranteed.

Agreed.

Oleg.

