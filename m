Received: from sender-pp-o91.zoho.in (sender-pp-o91.zoho.in [103.117.158.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13353C1F54;
	Thu, 23 Jul 2026 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784830950; cv=pass; b=ThVbYNFcg3DIfNJdBJDd5+4LC2/1NCSMI8quWu1OxSMhVODy3C2xNhrSQ077SSfr181VLWnA0X7BV3t/IpPmtQCE1F/RZWgpZc3i0EC2yku5NofbiWnunT6RjagpVgq++9YVKdL5NUG+LKZwXsAwSGm6rf00kA3CfFVh9PsbFTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784830950; c=relaxed/simple;
	bh=54BfALxmwVON3rTyEXchRklWjBnoIvHmx/wKfGySEeM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=nxmQ/Zi/KCtB/SaLTwGrLnVYoQrChwvbCxvv4k6u3CFMQgbFXF+B/rlwTo42FeLZ0cKNKM9oVGYUVv1uV1IJqhektAB1E+ALJWJqRD/gc5rJCN7rGyiLKWuwYVhv2u1wqMNZZXxjFL3waqCWSNOozcIugHrcytwo3dTIU2eLZc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b=xFbhv7mg; arc=pass smtp.client-ip=103.117.158.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b="xFbhv7mg"
ARC-Seal: i=1; a=rsa-sha256; t=1784830836; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=DhTCt/0+nbXkNrT16r/mYqwaIRGTbMZ2tJRdYDK5WwZpUIEEeJfZUR1W8jfmfNoMMYsi5G+xb0qoVG87YDr13cjS99F4mDYQEDHrcj7JVaJOKxPRHHOnG3J7xdlvZpsL9SCgT0rbN8ZCgY7x4hsBF62uyMsPvu+G5eB20yYGS7U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1784830836; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pfQDPqw11mCJJji2f0Nti4HsEvZmmxB/+DvabiWGe4o=; 
	b=bPYqK4TEtuGlf1Iv7tE1PiEybXOUGlCAEw7gRZ/ZLlxLhPVmtiOrDRuoEOxPP4lQNBxSRmmQ8+yQwkLR5WXBe6zAqgWajaQ7EZK3lPTbbFChZ1e8Sd0megUTWMr/Bh86mPSic74axVVNcWs3QEzfwEx3bu7jKTRange6P9Ey/EQ=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=adi.sharma@zohomail.in;
	dmarc=pass header.from=<adi.sharma@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784830836;
	s=zoho; d=zohomail.in; i=adi.sharma@zohomail.in;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=pfQDPqw11mCJJji2f0Nti4HsEvZmmxB/+DvabiWGe4o=;
	b=xFbhv7mgSE7zUFuoNZQrs81/lHXApMTmweZPcKCYwIOBAXqXUm6t+CFpPOy/2oco
	OQM8TDoLXmcxXoWM71ua/6HiyPvdT2BsNPin5Zh+xtkyM9VEOLNNBO3qzIYpGriqC93
	o2iv/A/Flgm2LP5+bHEg0TmCDbDQ+4QqI2T6x4vc=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1784830836074875.803576409499; Thu, 23 Jul 2026 23:50:36 +0530 (IST)
Received: from  [14.139.128.54] by mail.zoho.in
	with HTTP;Thu, 23 Jul 2026 23:50:36 +0530 (IST)
Date: Thu, 23 Jul 2026 23:50:36 +0530
From: Aditya Sharma <adi.sharma@zohomail.in>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
	"Lorenzo Stoakes" <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	"Vlastimil Babka" <vbabka@kernel.org>,
	"Mike Rapoport" <rppt@kernel.org>,
	"Suren Baghdasaryan" <surenb@google.com>,
	"Michal Hocko" <mhocko@suse.com>,
	"David Rientjes" <rientjes@google.com>,
	"Shakeel Butt" <shakeel.butt@linux.dev>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Masami Hiramatsu" <mhiramat@kernel.org>,
	"Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
	"Kees Cook" <kees@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Juri Lelli" <juri.lelli@redhat.com>,
	"Vincent Guittot" <vincent.guittot@linaro.org>,
	"Dietmar Eggemann" <dietmar.eggemann@arm.com>,
	"Ben Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
	"Valentin Schneider" <vschneid@redhat.com>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>,
	"linux-mm" <linux-mm@kvack.org>,
	"linux-doc" <linux-doc@vger.kernel.org>,
	"linux-trace-kernel" <linux-trace-kernel@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"imbrenda" <imbrenda@linux.ibm.com>
Message-ID: <19f90353d61.105539924624.2933593927158737842@zohomail.in>
In-Reply-To: <d6c3eba3-c596-4903-b298-ac6f424d639c@kernel.org>
References: <20260719185409.409685-1-adi.sharma@zohomail.in> <d1180a70-f4b4-4c22-9ce5-881cb0e2370d@kernel.org> <19f80cb1ed8.13fd666243425.2308143427066829733@zohomail.in> <d6c3eba3-c596-4903-b298-ac6f424d639c@kernel.org>
Subject: Re: [RFC PATCH 0/7] mm: defer address-space teardown of large
 exiting processes to a kthread
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail




 > CLONE_VM seems to work for the use cases you had in mind.
 > 
 > There would have to be a *pretty* convincing story why we would want more
 > complexity in the kernel to handle this.
 > 
 > Some smaller performance improvements are not worth it.
 
Having thought about it more, I agree. I have a workload of my own, 
which as you say, I can simply fix using the CLONE_VM way.

The only kind of user which the shadow process thing does not cover
is someone who does not have control over the source of task over
which they want such a behaviour. Here, the only case I can think
of is operators who cannot modify or wrap the processes they're managing.
I dont have that user.

So, instead of further argument or sending benchmarks that would
show a performance delta, does anyone on the list have such a
use case? If not, I would consider my questions as answered.

Thanks

Aditya
