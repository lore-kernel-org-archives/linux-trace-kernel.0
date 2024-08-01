Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A371A0702
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515219; cv=none; b=BLTCXUgQ0QPrzJunseh0O++MnAGEWvGE/TZ19pIp4AVbVNXiPj8qu4IJtRmn3Wdc/MqVgkPDZdkVETFiHj5A5lZs3jNqLopQeXgj7qe2u/5AGuy2oruYbE08jJg3vi+a8Mp6pELPr08W7kmzU7O5OSO/906THIm7Fcg9EYB5DEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515219; c=relaxed/simple;
	bh=XcvLHNXX85VbbLkLPMKUf8AGF87ba8yNC/NMs+hya9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlvvLvkPB6FEsc4DIu0uxgWL5l1icJgDPJgyjmXLUWhEjJnihnAcjaHHQK1uZ/jumZRWldJXeCSP41OWPcNW+8xU5YmDRT3K8SZlKOCkY2Rq83nmseb4KfuAu8idpPgLRHjsnGi4D7HxXzc1/0KZZfijYF4Gl3KXy02IjSgBpJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWPyRaS0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWPyRaS0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722515216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I556GNNSFTcruYrde4O22fNzoauDeX94dYOFtVAsxjM=;
	b=MWPyRaS0qSd/JDSP1kUJGF6+rLcPe9HsiiZbCmPyuj/iFu5nI5qRL7KTbfKlsZoNY/+l4h
	7jF2RB7S8X3qmLANgA62scGi3atXJf57XdqeJt4Ggz2yO8WqqRHdZR2MozK6hnG8e/XFr3
	Apvay8FXV18CytT/RbdjJHE2fcU/9wg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-0_IwIwDlNE20avF-0sBnng-1; Thu,
 01 Aug 2024 08:26:51 -0400
X-MC-Unique: 0_IwIwDlNE20avF-0sBnng-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ECF219541AE;
	Thu,  1 Aug 2024 12:26:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.183])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CA5BF195605A;
	Thu,  1 Aug 2024 12:26:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  1 Aug 2024 14:26:49 +0200 (CEST)
Date: Thu, 1 Aug 2024 14:26:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, andrii@kernel.org,
	mhiramat@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] uprobes: make uprobe_register() return struct
 uprobe *
Message-ID: <20240801122644.GC4038@redhat.com>
References: <20240729134444.GA12293@redhat.com>
 <20240729134535.GA12332@redhat.com>
 <CAEf4Bza1_njsVUad8so9EFxy8VmJsTfzaaAahBYFtOqdF1HAjA@mail.gmail.com>
 <ZqtyMTyu3uneHZDJ@krava>
 <20240801120018.GB4038@redhat.com>
 <Zqt8UPBC7zAWDMHD@krava>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqt8UPBC7zAWDMHD@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 08/01, Jiri Olsa wrote:
>
> > Note the additional path_put() in testmod_unregister_uprobe(). Does it need
> > a separate patch or can it come with 5/5 ?
>
> I think it'd be better to have it separately, the test is already
> released.. so people might want to backport just the fix

OK, I'll rebase and add the patch below to v4. OK?

Oleg.
---

From f6bf42015048938d826880e3bf4a318bb64a05b4 Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Thu, 1 Aug 2024 14:21:47 +0200
Subject: [PATCH] selftests/bpf: fix uprobe.path leak in bpf_testmod

From: Jiri Olsa <olsajiri@gmail.com>

testmod_unregister_uprobe() forgets to path_put(&uprobe.path).

Signed-off-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 86babdd6f850..55f6905de743 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -477,6 +477,7 @@ static void testmod_unregister_uprobe(void)
 	if (uprobe.offset) {
 		uprobe_unregister(d_real_inode(uprobe.path.dentry),
 				  uprobe.offset, &uprobe.consumer);
+		path_put(&uprobe.path);
 		uprobe.offset = 0;
 	}
 
-- 
2.25.1.362.g51ebf55


