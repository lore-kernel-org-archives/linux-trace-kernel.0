Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615600;
	b=wCBVGylBhbW0f8tFSH6VG+NxGqoMQzojDLAB6SAgeGp1g3r14ExssBBeiV3icPPCI27x
	 9H1FBN7esHA7D/0uQdptpcqtfDqjBvdWXg1dcnIp0YP+DwfCgfR1a3AKhW5/+JihmpsB4
	 hsQajTYRZoHYXWiOYpJuypzzmXfySpydrps11jzoqJx+f3lDAfTetkVxVZ3eMS4vlyvGP
	 irRuuA+hodZ8VhP9GoITiFERzP/scXGEy+VaNxrHdQyHI1I0pUk3W4Yq8YImpz0Zcbd90
	 q1ZkjUTN4yaWLt8nN024Em6voXb4gX9Pu5pP+4FLPa5AschwnCSMXxboP/Yk1kd2iJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615600;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Spam-Status:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=2IlmPAHO5FImUS3VMSQUR/U9JdcIr7V9eCHfnOZFD+E=;
	b=GqZin5o23wfKeI1msL5vB3NMywOyRqefG2C5M+rr2NExmh+o3TILn/ISSVmOFUuJiOnf
	 ZNfP8Y3z8VWUqxZoHHEMX1Vv95p6kjBTZe+B+xE5TAkBPyG7RFnyWWhC4dm3AHaV7oH8z
	 LRyT7XKl4khgWxfDdegHCC0rZUeq58tVHYRd/z1UXkHpoYfRUEdywSlYOUurpbTWi8fvh
	 /sv6GakUh3shKIWGdk12U6BF7VTXjiu98ENfSEBTvrkjHpdm+P95nBIA2o3SLfP9P7UbO
	 c0NHQ38ZR2BNH+hFpVwbIBSdUGi1R3G9XiQ4EiBa6Ww6ULKT5vXAuvRR/COYmc6N+/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=09KDKPED;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6144606A321
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 14:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6144606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=09KDKPED
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id A5655160E57;
	Wed, 25 Nov 2026 14:06:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id F05D92000F;
	Wed, 25 Nov 2026 14:06:35 +0000 (UTC)
Date: Wed, 25 Nov 2026 09:06:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Crystal Wood <crwood@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/10] tracing/osnoise: Variable cleanup
Message-ID: <20261125090634.745ce9b9@gandalf.local.home>
In-Reply-To: <20261113064103.3041704-2-crwood@redhat.com>
References: <20261113064103.3041704-1-crwood@redhat.com>
	<20261113064103.3041704-2-crwood@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ug7u83icyw5bfbk9qmfwk9n5wkaefijx
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: F05D92000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+EY7asFZQsgeiSGp546YrR2VVvz8T7UCs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=2IlmPAHO5FImUS3VMSQUR/U9JdcIr7V9eCHfnOZFD+E=; b=09KDKPEDL0SHd7RiskXVRUdDBC9KaqKvIbi3T5x83hJp1hsU7jdwHwXsdbyfHM4KuyOOi/B873yhzNjk+EzHV7vyEEpkvwaKTB75hL+ribJWdl5Hm/vmQVQ4yN798pm+QVrDQX4nzMUMKgnmsY7sRDDvLGqSRTRCPHpkQf/Nw0s=
X-HE-Tag: 1795615595-191674
X-HE-Meta: U2FsdGVkX18rBo7P79LJiyrnQ5V+2OLnlrdJVcUpo7sm95VzOWTaBBvG3vzauGN1wU3nsTHGqBf6zCkXA5lsK6GS4+HUlS8vF5aM0Y5aUuDeHniZNxT6jxLVsvPi8hfeMznEhAFOdqSlH37KdRkGVZ4VoOe8ZVg20wcpfYLhceCpQWYzOFmyOO5CbU9KLlQTKiJK0AZUwdG1yJW0jSp/vCAFYrEG/8s1H46QaDfxuPDQKNZ9MtpW/x0hLPBcjmwdxeXPO2yQd2fOQ2TCXmJuB9qSzqTdPQ3U4yGHvd9nh6VtlY+CpCpe4KZ2BGFYJfERt9lfQKgADnmUg0qDiosHsMEPJsd9dEDFv0MtmK0L2pfFNk3fjRNB9w==

On Fri, 13 Nov 2026 00:40:54 -0600
Crystal Wood <crwood@redhat.com> wrote:

Hi Crystal,

> Add cpu_osn_var/cpu_tmr_var() accessors and use them.
> 
> Timerlat threads aren't always kthreads, so rename the variable to just
> "thread".
> 
> rel_period isn't used at all, so remove it.

Honestly, I think this could be split into 3 different patches. I like the
idea of "one patch per objective". There's three objectives here.

1. remove unused rel_period
2. Rename kthread to thread
3. Group CPU access within per CPU variables

-- Steve

> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
