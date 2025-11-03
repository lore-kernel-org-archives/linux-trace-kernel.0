Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FFF26CE33
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177274; cv=none; b=te4qpv70CTVX/JDMSPDGBSu2nI5LrbN2sNpi1hWU5NQrAzg4wTJfcC25jOnUMzknw7BbJmIMApDmO5HURzKJZ5DzznnDjN9aMB1AR9Di8g4m64UOhzWYL5w+Vn6+ZTzlwZ6y/43OzeOyo2wwlRJzDLtHUEys2b5SjClv/GS3M+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177274; c=relaxed/simple;
	bh=PL5RlMkmVPmk8pKLO9PSfL1cPZTP9SlsAypQzCaWjyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKmyXYFjmK70E4b5M8XQtgGw/1YsKZp8VFlElFoNr35QbI2sRqSAhajIVHemFbWDo8eppP9Wqb+vkn5UMZ+CLKjJ6YR6NFpgwghn6ybSRnZzKrVrPRD+QdRKDY5E+wlok6KZE2UvBORrUzxxwRHcmB+6tiZkHXpZZ1rZVGEiikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EAtP9XD/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EAtP9XD/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762177270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1WpvrFRebBCZEATWkdnBi6tVWX1C17mtnJJUUIn6xQ=;
	b=EAtP9XD/Y0skpT+sQ5ptpddE2WBzXr7wLCsQqP3pvEkq7BMfiKiyogiqzgrd1TfH79hkOq
	RjAt39ZUpv/G2LUUzTs+u7RwvAHgCN+RauRVBzfNjHYb04B2n0cPkd1NVmgIP0v1oU4Vow
	zewqzCNlmmlidxsmPejXT6HqKJobMuw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-IlfE6v5vMyiOqv8jqKf02w-1; Mon,
 03 Nov 2025 08:41:09 -0500
X-MC-Unique: IlfE6v5vMyiOqv8jqKf02w-1
X-Mimecast-MFC-AGG-ID: IlfE6v5vMyiOqv8jqKf02w_1762177268
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FD3A1809A04;
	Mon,  3 Nov 2025 13:41:08 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.143])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 05714180045B;
	Mon,  3 Nov 2025 13:41:03 +0000 (UTC)
Date: Mon, 3 Nov 2025 10:41:02 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 6/7] Documentation/rtla: Rename sample/ to example/
Message-ID: <cydxc2a2oqb2gzkhzuvda476eirhw4gunrfrhs3apz26ua5q2i@7yomccokjozw>
References: <20251027153401.1039217-1-tglozar@redhat.com>
 <20251027153401.1039217-7-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027153401.1039217-7-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Oct 27, 2025 at 04:34:00PM +0100, Tomas Glozar wrote:
> The sample/ directory in tools/tracing/rtla was renamed to example/ in
> an earlier commit.
> 
> Rename it also in the documentation.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  Documentation/tools/rtla/common_timerlat_options.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.rst
> index 1f5d024b53aa..c6046fcf52dc 100644
> --- a/Documentation/tools/rtla/common_timerlat_options.rst
> +++ b/Documentation/tools/rtla/common_timerlat_options.rst
> @@ -64,4 +64,4 @@
>  
>          Set timerlat to run without workload, waiting for the user to dispatch a per-cpu
>          task that waits for a new period on the tracing/osnoise/per_cpu/cpu$ID/timerlat_fd.
> -        See linux/tools/rtla/sample/timerlat_load.py for an example of user-load code.
> +        See linux/tools/rtla/example/timerlat_load.py for an example of user-load code.
> -- 
> 2.51.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

