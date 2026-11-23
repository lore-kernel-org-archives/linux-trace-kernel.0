Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448030;
	b=OLt63RrlLub20+KmLrkM+ZY+yzBtth7Txyyew75qcXVgKWGQ1r/2zhVeRDafEEJ9ZaiY
	 2KdCY+YvC7fR86hNHarOtDKYc1WocidE/vQxCzUVsmyZF3pYSoKCBKX8b8Con87JPaJab
	 DPTchOA53jVymgz981rKYgxIJWqojxxoJqlIeR9UoxI3NkJ4ntd/DFB/U6xjeebhCyaDl
	 Z9rVNAjeUsNU5veacDPU1DO2t5pXYOcfzWxKrMgt0IB3wbPG80IuwBEYFLzENrcgjleas
	 G2gmAYaacwsadovgihcmYTrG4qjyq7SwThwG/gwsPxhBuzZgpI1wtrxI/GVP8c/NExA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448030;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:In-Reply-To:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=3eNnmtOvL0VVdRp2LWVT7myjX4/kd8itTt6EcJRcWRA=;
	b=A7sIXwB8+kvQs2SQXeVXSjKffQfcR8J5YrzOYsb4psxYdPH2NvbA5trez+p1L+eVLfFB
	 CleRrgjvGnzvw+Swm6jjIvUZ+GKeLJ9ZH2fOOFZv/nVPzvvFi5wYczWKvcy6Q123hbhM1
	 a6QQqsjU9jvhI7Hb2oKceZKR72TupKTABRYpksWjr3n+7Fv5hiSsWiA2SmX1MoEElD/LS
	 X+H07UW2Lmi72BNW1DLRJsgSTIr60mkZfDD32ofiMXG+++/YXwOp+lPAXPjVskuja4stl
	 ReXhL1Qsc1vQocdbwPJNn9DWhUehKSZ4q48iJwQIFTPNwCxMJzYEj0ut9AzCYo0WIfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iYgpvD4o;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD16606A31E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 15:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AD16606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iYgpvD4o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795448028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3eNnmtOvL0VVdRp2LWVT7myjX4/kd8itTt6EcJRcWRA=;
	b=iYgpvD4oyPmcID5kvR5xdr2lGoTACMeAccgYzaskn5aUpN1B1TNtAmNtwjK5p9J1pN9/7n
	X0am4Z8n0jrNHqgTIE7KjzIfuwyRjbJt+bMEe6q642bQlpXqnbUFZrCE1Fywl1vbvCA+H/
	TQWDNVwZjjHEGQGERJjuNL/xGGMKk2I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-RRgY3xe6Nx64RryZ1Mtg5A-1; Mon,
 23 Nov 2026 15:33:43 +0000
X-MC-Unique: RRgY3xe6Nx64RryZ1Mtg5A-1
X-Mimecast-MFC-AGG-ID: RRgY3xe6Nx64RryZ1Mtg5A_1795448022
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D694195E912;
	Mon, 23 Nov 2026 15:33:23 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 212E41956053;
	Mon, 23 Nov 2026 15:33:19 +0000 (UTC)
Date: Mon, 23 Nov 2026 12:33:18 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtla/tests: Get rtla PID correctly when system shell is
 not bash
Message-ID: <awRcoLq3Q8x8h3B0@wcosta-thinkpadt14gen4.rmtbr.csb>
References: <20261030145111.238098-1-tglozar@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261030145111.238098-1-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: rFSfY_MMKUOJzuc27XFar0Q3GXZ03nQKv-QadwMNtsw_1795448022
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 30, 2026 at 03:51:11PM +0100, Tomas Glozar wrote:
> There are several places where rtla runtime tests call a script with
> "--on-threshold shell" to verify the trace configuration in the middle
> of tracing. Some of these checks require the rtla pid.
> 
> Currently, the tests assume that rtla is the parent process of the
> utility script. That is, however, only the case when the system shell is
> bash, which optimizes the invokation of "sh -c script.sh" used by the
> system() function into just one process executing script.sh. On systems
> where the system shell is not bash (including all Debian-based systems),
> the system shell is the parent of the script, not rtla, and the checks
> fail.
> 
> Pass $PPID resolved in the system shell to rtla's --on-threshold option
> and use it as the PID for rtla to make the tests pass on all
> distributions.
> 
> Note that some of the tests (the cgroup test, for example) were
> intending to use rtla's PID, but work with the system shell's PID as
> well. For consistency, all scripts are updated to use $PPID.
> 
> Fixes: d18fd5a34ff3 ("rtla/tests: Add get_workload_pids() helper")
> Fixes: 7f7ad23bced9 ("rtla/tests: Check -c/--cpus thread affinity")
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Closes: https://lore.kernel.org/linux-trace-kernel/20260810210425.61435b0b@robin/
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

[...]

