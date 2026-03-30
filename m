Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E8137AA9E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Mar 2026 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774886518; cv=none; b=tXosQbykC5NIvjgQ4wSdFoqLEVwbHstKw86QxTh2HIDQtJAx1aADgOGm6tkfBDEv92XJANeNsyBqZFTNqtM1tQYVa6rqxdQupfmp35+oD7nGIce0q4MjP9qrVKd2ngNSd5LtOAiN/N3vtaeEg3fvg0hVcNnI2nWL1E/+EMWyCe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774886518; c=relaxed/simple;
	bh=4KAUMl3CukRLqfBbtMt0jYU1kk9Q0OpThfVpfHn4t4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GV9lOgu2q0FVb9/vQGWJpSX7P8sRW0WRzywS3cFVkR18DaGdfS8PLhn8f7z+TvGfTxsOso4BAP3ezmqxoHGsJlzituek5bmkJOWkQVAfs7JwfLh3rJ7Qlh3RaPE20DZFZGLxrnv4Y/giedg0/lituzgm4oJ99Y07GTpxaTZ0k7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J7VkAjb7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7VkAjb7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774886516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A61V9NUjB9y+KTxABrS5J5Rmozg5YI3T1/IJKQit0fs=;
	b=J7VkAjb721rOVGeSKn96LovwTl4AFeaH7xBkFE/yX90BHG/GAFeCqKtLkhd7gE0QuvUF/D
	k0rqT3OS+tp3j/W5F7ou5as7jRbKT2NTp+9d2jeZtXE9bZDDHiUas3sf1CMgOoK9EHhmrI
	DUoMdBqL7hlbgMw0GKy5aImAv/rW8Ho=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-5Z7tjCrJN46EF5vKHO2H2Q-1; Mon,
 30 Mar 2026 12:01:54 -0400
X-MC-Unique: 5Z7tjCrJN46EF5vKHO2H2Q-1
X-Mimecast-MFC-AGG-ID: 5Z7tjCrJN46EF5vKHO2H2Q_1774886513
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5442518005BA;
	Mon, 30 Mar 2026 16:01:53 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CAC4A30001A2;
	Mon, 30 Mar 2026 16:01:49 +0000 (UTC)
Date: Mon, 30 Mar 2026 13:01:48 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtla: Fix build without libbpf header
Message-ID: <acqeXj1AGZD33uPB@192.168.0.12>
References: <20260330091207.16184-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260330091207.16184-1-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: znjkwBRU5VW6C30j0IABpFBFg--T6xAS6l0HQkjZh_U_1774886513
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 30, 2026 at 11:12:07AM +0200, Tomas Glozar wrote:
> rtla supports building without libbpf. However, BPF actions
> patchset [1] adds an include of bpf/libbpf.h into timerlat_bpf.h,
> which breaks build on systems that don't have libbpf headers
> installed.
> 
> This is a leftover from a draft version of the patchset where
> timerlat_bpf_set_action() (which takes a struct bpf_program * argument)
> was defined in the header. timerlat_bpf.c already includes bpf/libbpf.h
> via timerlat.skel.h when libbpf is present.
> 
> Remove the redundant include to fix build on systems without libbpf
> headers.
> 
> [1] https://lore.kernel.org/linux-trace-kernel/20251126144205.331954-1-tglozar@redhat.com/T/
> 
> Reported-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Closes: https://lore.kernel.org/linux-trace-kernel/20260329122202.65a8b575@robin/
> Fixes: 8cd0f08ac72e ("rtla/timerlat: Support tail call from BPF program")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/timerlat_bpf.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/tracing/rtla/src/timerlat_bpf.h b/tools/tracing/rtla/src/timerlat_bpf.h
> index 169abeaf4363..f7c5675737fe 100644
> --- a/tools/tracing/rtla/src/timerlat_bpf.h
> +++ b/tools/tracing/rtla/src/timerlat_bpf.h
> @@ -12,7 +12,6 @@ enum summary_field {
>  };
>  
>  #ifndef __bpf__
> -#include <bpf/libbpf.h>
>  #ifdef HAVE_BPF_SKEL
>  int timerlat_bpf_init(struct timerlat_params *params);
>  int timerlat_bpf_attach(void);
> -- 
> 2.53.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

