Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4910837AA70
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Sep 2026 06:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849342; cv=none; b=orUA2zl7hv9F28eHNN6xqP/SVXxbmHgLapfI3Lor/eDW0uaUaGbczOBXcrAnCdcf32dR9uzyWMXjpgcR/BiNInzJWu/jxpwWS76Oe00esfS3URMgktasAIh3YQ5HrX3N9caeBH21Wwn6oEjcaENab6y4iUiL41lh+PE7dmVEPso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849342; c=relaxed/simple;
	bh=VcsRTcR7UvmGPi3UVltnJ8Mvdqg2EXaylPcDLJc0IKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=vDN7yNZyYfDgLDNXeJWxLKc1U/fGzKUO53MgQTXThT4RHjlJ/xVDaqkZEqy18zFWoziOMD1tP10zI2M4VAxiJg7YCRIlcTLxC2wgSykOvnriEY6HBPiWjUX8VoGxpbSFlzrKkswYaBnL64l+ZvdSSnYCGpmDk50y+f8ZeBeZEEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KdHlfohf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdHlfohf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788849340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VcsRTcR7UvmGPi3UVltnJ8Mvdqg2EXaylPcDLJc0IKg=;
	b=KdHlfohfvLvrDAI8Xw8uYDYW0l3hoLlHjX5hSvlT6TgApRL1FBL/4F9m3MCa2Z6A/WRa5E
	bcFGrjEoqxsoNInpZGP+DFrF09STo9/79yjsCX9myf2abYkowDNXinaJNazk1GcuqpIqqF
	PolKZH6uxrCe2RBqEWQzIzZAQPDh+P8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-1sG3jvg3MiK2a5xYuG_qMg-1; Tue,
 08 Sep 2026 02:35:38 -0400
X-MC-Unique: 1sG3jvg3MiK2a5xYuG_qMg-1
X-Mimecast-MFC-AGG-ID: 1sG3jvg3MiK2a5xYuG_qMg_1788849337
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 920641954222;
	Tue,  8 Sep 2026 06:35:36 +0000 (UTC)
Received: from fedora (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A93311955F08;
	Tue,  8 Sep 2026 06:35:17 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  8 Sep 2026 08:35:36 +0200 (CEST)
Date: Tue, 8 Sep 2026 08:35:16 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Gregory Price <gourry@gourry.net>, Ye Liu <ye.liu@linux.dev>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>, mic@digikod.net, david@kernel.org,
	linmiaohe@huawei.com, nao.horiguchi@gmail.com, gnoack3000@gmail.com,
	ljs@kernel.org, sj@kernel.org, rientjes@google.com,
	shakeel.butt@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, tony.luck@intel.com,
	reinette.chatre@intel.com, x86@kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, pavel@kernel.org,
	lance.yang@linux.dev, pmladek@suse.com, longman@redhat.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, dietmar.eggemann@arm.com, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, mark.rutland@arm.com,
	Dave.Martin@arm.com, james.morse@arm.com, babu.moger@amd.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 5/8] kernel: convert process/thread iterators to
 for_each_*_rculock
Message-ID: <ap-spMNyMvYFga5k@redhat.com>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-6-ye.liu@linux.dev>
 <ap7dC-LWNaoPYJvv@gourry-fedora-PF4VCD3F>
 <ap76-0-hN6CAcYXX@redhat.com>
 <ap8mgnpE7D4TTrno@gourry-fedora-PF4VCD3F>
 <ap8yoW37GY17pHYS@redhat.com>
 <e618ace1-6a8b-42c5-8a97-44b39dd1a7c7@amd.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e618ace1-6a8b-42c5-8a97-44b39dd1a7c7@amd.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: Kp-DoJbV6zZW_ZKwVbQKbgDA_TZCCvEF2eiPB5Ys66s_1788849337
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 09/08, K Prateek Nayak wrote:
>
> On 9/8/2026 3:24 AM, Oleg Nesterov wrote:
> >> This might be my - admittedly shallow - understanding of scoped_guard,
> >> but does scoped guard handle goto correctly?
> >
> > Yes, it does,
> >
> >> and why it's generally discouraged to mix cleanup.h and goto.
> >
> > Hmm, why? I didn't know...
>
> Apparently older GCC would allow subtle bugs with cleanup + goto to slip
> by but clang has always caught those bugs and refused to compile so as
> long as clang builds are happy, things should be good.
>
> Here is an older explanation from Peter:
> https://lore.kernel.org/lkml/20260327154136.GL3739106@noisy.programming.kicks-ass.net/

Ah, but in this case the code is buggy, "goto unregister" jumps
into the scope of __free.

Anyway, I agree that mixing cleanup and goto can make the code
confusing or buggy, but this particular case still looks fine
to me...

Oleg.

