Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81A4215F42;
	Fri,  4 Sep 2026 00:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481819; cv=none; b=qqUavQ3YeEJ+LSaibPwOKITdZsdaSD5CJZkggvJRD6yciaFvha/gN7ZMkTveVruZ2FEI69NjIjrX6rgsGBO100F6YLbEE05twFOpKFO2ug7fy7R8oou9sI71QxPNy4IKw3yKDQycYldIIHna5feEDtGWM5NG9zan9ksMHHRkdxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481819; c=relaxed/simple;
	bh=5tfzxWvcAcE9z19VaN4NdDaFsJ/dRfIsSrvpxmGW5MY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bYOPq9L9q29lcT7uRw8F60UWoiyFksrltYDeZSFnEAlLPZsS8iWzUPA11UH6xEycFIqFvDlqBlihDXDKTY52PHc/He3fYIhFftvkqWHcBfk9VuhyHs2boi2tGEhlImRAnZu/qegYXx9JTG0eCithxHVYGD+ooVbZdmVLxNWL/Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=5uv5hrBh; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="5uv5hrBh"
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 1A44980686;
	Fri,  4 Sep 2026 00:30:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 3BE8080011;
	Fri,  4 Sep 2026 00:30:14 +0000 (UTC)
Date: Thu, 3 Sep 2026 20:30:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peng Donglin <dolinux.peng@gmail.com>, dolinux.peng@gmai.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 pengdonglin <pengdonglin@xiaomi.com>
Subject: Re: [PATCH v5 0/3] Use BTF to trim return values
Message-ID: <20260903203013.6c844daf@robin>
In-Reply-To: <20260904084808.12a9c7a1c4bb8353d753e026@kernel.org>
References: <20260901134604.4052265-1-dolinux.peng@gmail.com>
	<20260901135715.4812fde9@gandalf.local.home>
	<f18beeb4-f3df-41eb-9990-5be295a2729b@gmail.com>
	<20260902235533.ea387f764b51b1b2a8ce8224@kernel.org>
	<20260903123606.6e5bc37e@gandalf.local.home>
	<20260904084808.12a9c7a1c4bb8353d753e026@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 3BE8080011
X-Stat-Signature: 5pde3kcwz8gmbofrgzwmezeiunb6xzy4
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18CFQi64f9itqFfsunw19izu8BlY02S8KQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=6mYFp4FTAtQ37/5I3wYiIODvfgIjO6uSxYfjLX35R8o=; b=5uv5hrBh8LeGCk9XbiXGIRBSqh/FJc7FtJT/Yand/TKh1kQ+4ZEWznNXkOktaJkxhXUrUsIBlmCL/V08PkhJ1/hmBSaGu9PREwb23meP7hqP4q/FqR6eofFXl723GlSC9zSKXX4eEVThc/hIbEZKVLQQWcdlT+4efZVyvryW23c=
X-HE-Tag: 1788481814-26337
X-HE-Meta: U2FsdGVkX1+4vccXVtd69NkEwp/fgT12FFWoiRZtP1pqzI94+bpA8BVYX/a1g90eBZNxsaTyrF1Klw/RJClzFjy/IuLbfUXAFdRIx9RynvITSITrDd9uT1QIVk4j3PU3MhYrOYwTb9Pe9WUL2XdIvrcXQWTFPxlKbjDTzi+lzmUgwD0XcbG1RFM0YCjMvsbUF8yUojVIwBP19KOyW+NOfK4dciOr76uUAjQgNgnPtnLbBsCdIM4nT3QgpK5KfMmHYzTOm6bqOW3ozXZSGsigInPNcFLAlGTYTr5qNkySJzHJQqCCuy54/zqDKgkBkA6ShqXAa5TEh9yenK1LE+nIf7FhFv7IP5yg

On Fri, 4 Sep 2026 08:48:08 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > I have to ask. Why do we care? Is there a use for this information?  
> 
> If the structure itself is being returned, representing it as a scalar
> value could lead to misunderstandings. Since we can check it is a
> scalar or not, it should be noticed. In this meaning, I think "(trunc)"
> is also good to me. (at least user can notice it)

OK, after thinking about this more, I agree that "(trunc)" is the better option.

-- Steve
