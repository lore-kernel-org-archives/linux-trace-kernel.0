Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6122E2652;
	Thu, 21 Aug 2025 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787876; cv=none; b=d+Gdf2rglhTG+rfEOqA+Or7kJRdXY8YQN2/NOKs3w/xzE4dOld11z0DLuTGxDpmQy5z/wGQH/jhVb1OgW3aZeaW/4iBN5IJfkr5YW7twY39in7H5vxByJZqnyKH5wNJjmbpxmYrhxS8zI87r9y20bc17gFaSAMWJFp9OD1reIgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787876; c=relaxed/simple;
	bh=Q5SlGnzprzol8hHGM/DgiPfVeoO8lUYZN1Vobdm3T2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nsh7W5yRprPYg92QpWPqxAa8K+MkQcz55Mmc2G6BsZscGOn2GxICnOB9XtZ3llHHchwNEFeQiNO6SBE6RQ+PBvH5cmhIyO0KgGEbZjLDiFQun50KX7SjAscgs0DTQSSbO/8fBW/h5LADJmyMh0P+trbZVbbUQTW9ZSZILCrQbFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 1ED891179E6;
	Thu, 21 Aug 2025 14:51:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 016152002D;
	Thu, 21 Aug 2025 14:51:09 +0000 (UTC)
Date: Thu, 21 Aug 2025 10:51:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@elte.hu>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ftrace: Fix potential warning in trace_printk_seq
 during ftrace_dump
Message-ID: <20250821105113.1536d567@gandalf.local.home>
In-Reply-To: <40bcf20b-e2e6-442f-bfd8-bb7ad6245397@huaweicloud.com>
References: <20250820090017.2978279-1-wutengda@huaweicloud.com>
	<20250820101054.50c0b8b8@gandalf.local.home>
	<40bcf20b-e2e6-442f-bfd8-bb7ad6245397@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 016152002D
X-Stat-Signature: k8ow5iq65w5moriaz7fkyt43xgmnuebi
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19L5VTg/ZWspln2JRMI8I6QCe09F2Y8DyI=
X-HE-Tag: 1755787869-217156
X-HE-Meta: U2FsdGVkX18ICm2o0R5oBo4ZNSCykoFTh4tTDm8vB4C2k0PlZT6OfTrHmAiA3viZWrtuHVvI1b8A5Fu+oeJrUXVjD19QrnyvFEuoTWnmD6SQNowtJkzdNrVGdNrA5NsfTTz8vbLHAJUU/+Ec7SkDTSy2q9A5UoMeOiCYRErVxMtpFfd7Miacx0ft2YYNTVWWJnIABVmw1VuzzkbPLggmoO8oJoCOFkvVIt5Sluv4bQQXAvILjIMtZHXnVFin2g45ogULUkSZoUCndwyN+sCDd9+tbAJv18GJBiqNmgR0NiAMpzAWgSXFedMuZt8X2GtQqHSA/148jeMLs36YQ84Fv0KK/PFyYOcH

On Thu, 21 Aug 2025 09:53:53 +0800
Tengda Wu <wutengda@huaweicloud.com> wrote:

> There remains an edge case that concerns me: if size is 0, setting len to
> size - 1 would cause an underflow. Should we handle this edge case?

When the trace_seq is allocated, the size is set to 8K. If size is ever
zero, then there would be no buffer. So no, we should not worry about that
edge case because if it happened then we have a lot of other things to
worry about.

-- Steve
