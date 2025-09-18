Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F61255E27;
	Thu, 18 Sep 2025 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215133; cv=none; b=GLB3uFgEVDBakFKqw8d2HkS/N6H3MA+S7OdSajM1OfcJODLUFxvusuU4A+tpYYxGeu9B0LQmv9srXIuJf6VKygocj38O9Uq54m22mCzovTJMWuMZz0t3iX6GiKkT1IoyULt8GKCxtOw1jB39Fn7XojvwbrqBzYsxEOLtMzcPsIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215133; c=relaxed/simple;
	bh=X/POsIVTv8eNpfgINUCFzeDvZfWq0I5UrNuXSk5IxQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnHFl2+MNGl7itLT8q6t7JoSFSw3D5T6YsajU7Os3UJ2nldOW7rFVD3NPQzCaIvQ7RBOXx+J3ho0iIpdW75QoRMvCrLK1NcNZ41WEgJjA/X16A+2nJ2KHpSprINiHpKiqRrad33KlHpOiofpqksbG54CU+lMXtHMwby9FxrrVUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 048B85830E;
	Thu, 18 Sep 2025 17:05:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id D4E073F;
	Thu, 18 Sep 2025 17:05:20 +0000 (UTC)
Date: Thu, 18 Sep 2025 13:05:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Kernel Tracing
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v2 0/5] Histogram docs formatting cleanup
Message-ID: <20250918130519.06294a16@batman.local.home>
In-Reply-To: <871po390m7.fsf@trenco.lwn.net>
References: <20250916054202.582074-2-bagasdotme@gmail.com>
	<871po390m7.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5jfb1czsre9tiux7xn8rq9sjan85h513
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: D4E073F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19fs3V881gWiGm8PDl6FigPUw9X2RlD9Ow=
X-HE-Tag: 1758215120-677576
X-HE-Meta: U2FsdGVkX18qAq/L8Rsa+fhxL5hEE9MCOF613M9C6KOdcg+eh7NXkpJcD1Dz53GMS8IF3nhmmD1hxfuBTtmNImt6BAxJBwTMieg2gmp8nvXSXivLKgogERpDuyH/EEbdA3b24vGEmb9fIdyBPINn6H2PPWRT6XJmvJnMLMHkO5N4+0Q2wSCc3bl68yIS/NO0U9k+GJPjTtkcL8Rv7/+g8RcM7sZzvz5jDlmZPsnzIqZ3SSMj4qxlIMBuHejwrZarBeWlgDgusWwAU1sxfOw12NLus9RwfazT1WMrTR7LlE5pooYrrW2SLSo5gd23CHLa7srK5+1MjyPBg899rmuXVo+Ep4pHuv2glM0l+jqTJ8+OGfFuh7RjwqFfckBX/dB6npzCj3vpHA+g5RFxHY75ErCtQ1dmB41LvZa0SbhSahkm7u5kJfG60dLMXEZ2hllf2uwzaURgjpq64AzLZY7ECA==

On Thu, 18 Sep 2025 10:38:56 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> Steve, will you pick these up, or should I grab them?

Can you take them?

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks!

-- Steve
