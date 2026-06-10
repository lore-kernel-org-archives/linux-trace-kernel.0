Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C40C403E9A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095994; cv=none; b=WJMYruvFV92J0psPcYoIyp5y+ce0HCszbILMTN5DYTO9Z7BTOVeVVcaJrS0Ue7BGv7A02cgErAW7GLHZBFmaJG5zX2FhbUoL8HaXgjAX6JI/eHUw6SyUPPK4B/EIG3WLHUS1gDxEDKR+N9QyuXnh1yF8gyI+zb6cG6fl/zdMSsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095994; c=relaxed/simple;
	bh=DATOvWEl6+vDj4fLhlUgx5WnFdQYxwtsQEm+0x/7pug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=E9ZdlQFlYMgSzsutlVksszGyeZTYzNCpY5hl6yDRV/3S/hmRUVshGc7Lh8WnGC8RunB3yHvGVTGWNglAxmQJDn/yMJp8wAHLb7fNXuU8ijrjiy1LcEyTMDZSK1nWXfHUY9SsuLs2P8J28vrs/y53usQUnkYUZtRlCglvkIq7/1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIuzhPEn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIuzhPEn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781095992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=trFbMzecFCDTtqHwsmaw0L+K6xH6b64MKxE/VNfXYic=;
	b=UIuzhPEnfGyiHcXGr//FZDU0/1YCb9mPKR7RH8ZUx8c0nqvsnlhbUydol4rlFP2HTkNTMo
	Bc+FnieWeadsc6MjMeQLxgKCgeJnE00UAwaqB4wHzqtpf90AkvQGvJIgZzymGmFE9HSjWq
	f99gEFlEVvi/Qv09jJDolEFX1sP5JqI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-9TApDTkROqGRhtPQb9FWdg-1; Wed,
 10 Jun 2026 08:53:09 -0400
X-MC-Unique: 9TApDTkROqGRhtPQb9FWdg-1
X-Mimecast-MFC-AGG-ID: 9TApDTkROqGRhtPQb9FWdg_1781095988
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27B25195F170;
	Wed, 10 Jun 2026 12:53:08 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.196])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8068B3000223;
	Wed, 10 Jun 2026 12:53:04 +0000 (UTC)
Date: Wed, 10 Jun 2026 09:52:57 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtla/tests: Fix pgrep filter in get_workload_pids.sh
Message-ID: <aileE5m97jq4wME2@wcosta-thinkpadt14gen4.rmtbr.csb>
References: <20260604140547.3616495-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260604140547.3616495-1-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: xnV5mkJf9EWdUwoRUIW_lKOzkhlf38tL9miTUIbIsoE_1781095988
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2026 at 04:05:47PM +0200, Tomas Glozar wrote:
> Multiple runtime tests in RTLA rely on the get_workload_pids() shell
> helper function to get the PIDs of both kernel and user workloads.
> 
> On some systems (e.g. Fedora 43), pgrep matches kernel thread names
> including square brackets: "[osnoise/0]"; on other systems (e.g.
> RHEL 9.8), brackets are not included: "osnoise/0".
> 
> Accept both as valid workload PIDs rather that just the non-bracket form
> to make the tests work on all systems.
> 
> Fixes: a98dad63cda3 ("rtla/tests: Add runtime test for -k and -u options")
> Reported-by: Crystal Wood <crwood@redhat.com>
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
> 
> Note: the file touched by this commit is included by .gitignore, that is
> an error that will be fixed by [1].
> 
> [1] https://lore.kernel.org/linux-trace-kernel/20260601091835.3118094-1-tglozar@redhat.com/
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

