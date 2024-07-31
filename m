Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4501A76C1
	for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722412626; cv=none; b=CygLsOH1FGAxD2P538I3kkDMCYvnCm3RjmWUuCppr5BK+eJW354aBizn+unRf36iXuNST5QOJewrj/JRJen/ueo6CaVsDVnlVxeipFhs749I9RhL4bH3A8oLUcq+rdIEKbvlrblPlB0LAD+Nt6zwtmIAhmKDKxD3nsZz50Mp5IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722412626; c=relaxed/simple;
	bh=ozgdOpWtF81Hf/gEOh3bpv8GZZcV0210ozHrG8wclUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aP5Y6TFD6MhS6Gk1qI2qygyuf87Mg1HSHju607RPKDnlO3IEUkwKR3V/tP+4uLga0Co9bBOScCov+Waf0rltZmpbD7vyPcMPyV/RCxjp6wYZwD9F5Mm3BRkblz589Z/fJfixAfnuy/G+ZTQ7qH2fhknriqH65R/JdkyVoO3yqeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NqFsm2Ke; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqFsm2Ke"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722412623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9AaEcQYPcilFXNuPPHJ/dNKFao/QXRMpFdXw24PBoM=;
	b=NqFsm2KeIxVGM7Q268PVrCgu6XLJ0jaNyGgE4cAEJAjweUyjnSv2lfykl1UfBUeVrXaHN+
	T1w6IfT1WOmQ/yFPRaX48GpSFBvppCKLAF94IYrIC6OaD9MYryJfp6VgkyRmR9nzb97wzR
	8PK4HhfJ4AE7f9/xNR+7JIh3UsbcAQA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-C2IrSy3XMNKsyP_OYuMCBQ-1; Wed,
 31 Jul 2024 03:56:58 -0400
X-MC-Unique: C2IrSy3XMNKsyP_OYuMCBQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20CE61955D4C;
	Wed, 31 Jul 2024 07:56:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.143])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0611B1955F3B;
	Wed, 31 Jul 2024 07:56:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 31 Jul 2024 09:56:56 +0200 (CEST)
Date: Wed, 31 Jul 2024 09:56:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: andrii@kernel.org, peterz@infradead.org, jolsa@kernel.org,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] uprobes: kill uprobe_register_refctr()
Message-ID: <20240731075651.GB12813@redhat.com>
References: <20240729134444.GA12293@redhat.com>
 <20240729134530.GA12318@redhat.com>
 <20240731143748.55bb97c1d68aea1f1946729d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731143748.55bb97c1d68aea1f1946729d@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/31, Masami Hiramatsu wrote:
>
> OK, but it seems
>
> tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>
> is still using uprobe_register_refctr().
>
> That should be updated too.

OOPS, thanks a lot :/

I'll send v3 with the additional change below in reply to 4/5 in a minute.

Masami, Peter, please let me know if you want me to resend the whole series.

Oleg.

--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -458,8 +458,8 @@ static int testmod_register_uprobe(loff_t offset)
 	if (err)
 		goto out;
 
-	err = uprobe_register_refctr(d_real_inode(uprobe.path.dentry),
-				     offset, 0, &uprobe.consumer);
+	err = uprobe_register(d_real_inode(uprobe.path.dentry),
+			      offset, 0, &uprobe.consumer);
 	if (err)
 		path_put(&uprobe.path);
 	else

