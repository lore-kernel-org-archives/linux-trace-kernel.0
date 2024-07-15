Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822782421D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jul 2024 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064223; cv=none; b=JjqU8vNBMaMEPYlsRB9IImxZvmCDApvjuN1LIi0DIvQQ3Jm8eiG4NI6VQOR3Vk4NoizJauH7P7Bqd8g+tO/zbbMSTzeytJblpQcy19HYJydUqFG008xNIJFETYKB1iTaxPvfc2pDMWKVbxQVev7Q8RpmVuDRdN2FtsHEDgzbU9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064223; c=relaxed/simple;
	bh=Yn9UsdTXq5qs6s0t/ZhLNW2lYcFWMWhKSZF03l3zX5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLVPr9Iw6WQoFrS/3zKC61zSi6wx88uNbTHpaXflwWH1MnA8oFvoqxoMgvjISByksW34GFDbGbPycldB21SofaAJbGafyB8HfXOa7F9NZfTqz8wg3CEbUOcw2eEFbttu41lhONB87gZUDCsJObs5VeIYbXoVUhwphuc5Fbtlx4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gdFt8/Fz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdFt8/Fz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721064220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yn9UsdTXq5qs6s0t/ZhLNW2lYcFWMWhKSZF03l3zX5g=;
	b=gdFt8/FzMWW5v5HtS3t1jcpIhX+Y61Ghdpd5d/uhrkAaqPoCKN96nsanF7BXB4yf80i33I
	T79a8zBVSZdJc2lKVkX1hy2YAGmSogeVDoI95hSnT8n+E0Ra34T9Q7HygSg+4erfPlkw0V
	sA+KcFARy8uuCwe8N5Hoc9UN4ZtoHEg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-BLuKU4gvM56sSe62T6boQA-1; Mon,
 15 Jul 2024 13:23:37 -0400
X-MC-Unique: BLuKU4gvM56sSe62T6boQA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5346E1955F65;
	Mon, 15 Jul 2024 17:23:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8DA891955E8C;
	Mon, 15 Jul 2024 17:23:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 15 Jul 2024 19:21:57 +0200 (CEST)
Date: Mon, 15 Jul 2024 19:21:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, mingo@kernel.org, andrii@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add uprobes entry
Message-ID: <20240715172152.GA15187@redhat.com>
References: <172074397710.247544.17045299807723238107.stgit@devnote2>
 <20240715181417.6421de1e1a18a39685533115@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715181417.6421de1e1a18a39685533115@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/15, Masami Hiramatsu wrote:
>
> Hi Peter, Oleg,
>
> If this is OK for you, please give your Ack.

Acked-by: Oleg Nesterov <oleg@redhat.com>

