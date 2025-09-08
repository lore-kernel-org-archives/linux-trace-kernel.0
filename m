Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B37523956E;
	Mon,  8 Sep 2025 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358181; cv=none; b=O/gYtD/U/ohptuEBYA6zq38bzd74+cDdMcdovS8YBWoNQmXisBBaSaD61D5Q6hnf4lqvkUZqjde7EDjkSNvSG6k1Z5cNoaA5DaQFwTr/F25AsOuYENZQbVXZCLzX8o9d9xPRgng2LbPohtqXP8amcxo2PkJbnYH7bPIqL6U9/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358181; c=relaxed/simple;
	bh=mnBtt7xr2RuUmCIMbAoc2ycJM3QJ/+ZOGiTncOOqyuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eq8AuaCIkJn2ANnz8Bd6qGKS5DXI3E8ql89GVE3HXOPTytz65PhH9GPUvHYDQhjZdBd2SMdclc6UJpEX/9NPih/2aHDg90RKkc7hX7928ycTIVlhLkXiUHorsG04gfAnCvVIOci5IpBf89yGUNlcQX8lHAQuTwNPeku9koCTAZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 96FF611929A;
	Mon,  8 Sep 2025 19:02:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id C878F35;
	Mon,  8 Sep 2025 19:02:50 +0000 (UTC)
Date: Mon, 8 Sep 2025 15:03:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Silence warning when chunk allocation fails
 in trace_pid_write
Message-ID: <20250908150336.76db8c6d@gandalf.local.home>
In-Reply-To: <20250908150257.23731d24@gandalf.local.home>
References: <20250908024658.2390398-1-pulehui@huaweicloud.com>
	<20250908150257.23731d24@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4z7xu16afru1dtmgch14ym57i5srxm49
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: C878F35
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+RLeiIronzznepWhY1bTPSbViX0oh58jE=
X-HE-Tag: 1757358170-631092
X-HE-Meta: U2FsdGVkX1+cAR3irpmZTSE2b+yjbYRKvmb/BvVZByuZREhrPEjSTKmmdJekjc512ldft+5+FY3aHOiroz6j7rgAt4R59mE8tBpRyFyf2Uo5vEhWNvZGNqiEAMTSqgRZSO0BlawujtcaUNm5h5TOr17TnkJifClJ5Qw7BE9nu6/Ix4XyyCNJzgy4pkEkY47Xsxd+jB5YoLCi52DKa0nceuamiKPh+bQCZWLl9ZbDTjp5oCgSnkeMh2JaInqhSXVSeL8wsj2MxPiU5TLYAGHo1y9I+5tZ7x9VVnyc52JHrMZjHT+wKPrGd2yvU5ZGsXsW6h0kcWSx23JWHPL/+EqoyMAvnbVdh0uODJ9FuAgtn71XGR6nHhEV9hUT4AqxNAGe

On Mon, 8 Sep 2025 15:02:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I have a Link tag to this email that is added by my scripts, with the idea
> that this email will have a link to the previous version and so on. It will
> create a chain of the email discussions that lead to what lands in mainline.

BTW, I purposely replied to your email to create that chain ;-)

-- Steve
