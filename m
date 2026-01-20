Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8112046AF11;
	Tue, 20 Jan 2026 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768942347; cv=none; b=gtl+v02eogMk5mKWQLbEwjnlXnlbJ5ZpySfqd4xWUAhWtgsLHAIkLGH357wWCecZLHKOwXB4qBOEqkpUS420jun4LvGiPjygb5pbkJGqP39JG/LBbNYb2f1ySiq927ShwJqEsjTzuzF+7E/6nWB4dasgzzme0d1XXSD5GMyd9BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768942347; c=relaxed/simple;
	bh=00n0fLfsfDCx4gdiwdM62kb56GKHGHB45qkTVyYtnYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJ1cwYqls5lzdffWrjX/Ap/QN3px/3zdhpHUOtMwQFtLRDvyFEimLM7Yts339N85TSvEuWb2XhSsqzG2/NSlPcUVa/SaFGW9tKfZEUp0OV1NYp3OfYqAFGUJqJsqHEdJNPzaVY3klQ8IvtkHlpy5oO7Lc+baHJtI7c4F2yXqmPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 8E214BAE46;
	Tue, 20 Jan 2026 20:52:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 7CABC20030;
	Tue, 20 Jan 2026 20:52:16 +0000 (UTC)
Date: Tue, 20 Jan 2026 15:52:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Cc: mhiramat@kernel.org, corbet@lwn.net, shuah@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 1/3] tracing/fprobe: Support comma-separated symbols
 and :entry/:exit
Message-ID: <20260120155238.37616f9d@gandalf.local.home>
In-Reply-To: <20260120155047.4ef3c378@gandalf.local.home>
References: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
	<20260114221341.128038-1-seokwoo.chung130@gmail.com>
	<20260114221341.128038-2-seokwoo.chung130@gmail.com>
	<20260120155047.4ef3c378@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ept94o76xo99npw3mjdtthncxcum4hhm
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 7CABC20030
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX194K4TRI9Oslw0k+/N0Nt76A+kzT6Kdegw=
X-HE-Tag: 1768942336-100826
X-HE-Meta: U2FsdGVkX18YGlVzpMQpu6dXiTD0nLIo0ZqiVmYfSzu4OBMw95WQ9BkQHrrVMACZF9zCKrGUnl+Cv2KNrkQ0Iu5wHgpYRTEji1TAG0W8g/6XXkyfzoExwy2tkJYcE8gEWl+MIsJPIaeClwUm7IGvj5k1kC+vBu+iBOUyTRFZ9d9qSMi7VLdMVQRHmxgbvqOdBFF5Tb213P4UZGxB/hEUyAW6IN4LHtvZ9j2mBrRc/K+r+huisnvBTa/0I8x2L7I82yExUprlf/VWRu556dUpPYZ/KEpJoqjXr+YlwY9EKf2bjuuFOxIXvD4wquOS+Qh+5Q9WYrDMFSj4bR626ITYEmdV7BOAvr0FsGXhghwelqz8zeH3dIAAPsv/bTniyHbVoX3tBUFP+1PWwYLMl1DPCA==

On Tue, 20 Jan 2026 15:50:47 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 14 Jan 2026 17:13:38 -0500
> "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com> wrote:
> 
> Missing change log. The subject is the "what" the patch is doing, the
> change log needs the "why".

Ah, just noticed you sent a revision. I'll reply there.

-- Steve
