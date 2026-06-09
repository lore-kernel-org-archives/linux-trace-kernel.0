Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6501A3AB5C7
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006751; cv=none; b=WgFNX3Qj3maxETuiFuMbfeeNFgr9M8Fj5+FjFlyqRBgLRExPRxHn5AHOQCH0VgzWqT1w8w5bLGS4pkOhUyNMgCG3F/81jEkVe19tyc6k5X/Yl0pqiceZl+zyTPzpNDWGMpH0t4afrW/yMKTOYp4QTpGSd6XFkxztr9wwoVyBdfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006751; c=relaxed/simple;
	bh=r4jgTsbDBuHlfQLMsK7IDzzrGW5d4xG0og6jaXUqIy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=T4MiYMzJbC8F94fE602SxfMmzDngr46f/hvN7xDm2Qvc2r090N6aOdGjPFjg76fcMu9xKVOfGoatKwQoCZJ9v6ZcFUW7dYHY83qCXpQ98NcmN6UDb/PDMwEzhnZ3E87N1DHf2f6D0HpmHut+hLjURAuDKqcMDW5wIhmtbpasV1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bw+FeNDD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bw+FeNDD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781006749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qF6BY3F3ucjt0ieDKHCwxYl8JJmwAdazwSYD0P0e2g4=;
	b=Bw+FeNDD6iFiks6+TwTqaKAi8KEAjC3QvRIef2D0mhQOjCyhIHdOopj55/idgirhy8ref8
	SEwfE8tGkU4PocZlQHxDHchgCWpRj3tD2Pxy0I9LWU5XbB/rf790EJ7o197D9zHzJZ5EKw
	V1EmwpKJ6xSwmj2Ts0lg1DFecdDSzOQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-uTviGDzlMsqZgwdr_X7nRA-1; Tue,
 09 Jun 2026 08:05:46 -0400
X-MC-Unique: uTviGDzlMsqZgwdr_X7nRA-1
X-Mimecast-MFC-AGG-ID: uTviGDzlMsqZgwdr_X7nRA_1781006745
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0FF991955E74;
	Tue,  9 Jun 2026 12:05:45 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.64.147])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 092253008B37;
	Tue,  9 Jun 2026 12:05:41 +0000 (UTC)
Date: Tue, 9 Jun 2026 09:05:40 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Crystal Wood <crwood@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>
Subject: Re: [PATCH v2] rtla: Stop the record trace on interrupt
Message-ID: <aigBcatMTt2LJvdD@wcosta-defaultstring.rmtbr.csb>
References: <20260512173731.2151841-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260512173731.2151841-1-crwood@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IktDUhhhHezBD5g03N_5Z1SPtoT5DvymCi5-CTRc08k_1781006745
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2026 at 12:37:31PM -0500, Crystal Wood wrote:
> Before, when rtla got a signal, it stopped the main trace but not the
> record trace.  With "--on-end trace", this can lead to
> save_trace_to_file() failing to keep up, especially on a debug kernel. 
> Plus, it adds post-stoppage noise to the trace file.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
> v2: clarify that this matters for --on-end trace
> 
>  tools/tracing/rtla/src/common.c   | 19 +++++++++++--------
>  tools/tracing/rtla/src/common.h   |  1 -
>  tools/tracing/rtla/src/timerlat.c |  2 +-
>  3 files changed, 12 insertions(+), 10 deletions(-)


Reviewed-by: Wander Lairson Costa <wander@redhat.com>

