Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185E5441636;
	Fri,  7 Aug 2026 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786134412; cv=none; b=tjGPVbMEIpzafWMgturlRJh07ApEDhqxyAdieyUt7M7N38Lb5Q1yjxBHpkWOFg0kbhQOoNZpsFExxo7velvTsY9Q0iP/JU/WksRFDIINtMIN6Eb2M1xZB+SNYy9Jee+1Wk2LYzJHtQXsBGZVxZKdqjenFqobeSAHRdLeUtPa3sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786134412; c=relaxed/simple;
	bh=cSVRSCYcY1KrSikxm2IvKFXjVYA3Y6TaURRMmVNR4BU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+SH3IN7F7LKi3SpYe4Y5vqhNfPh8ZvO8SR7B854qdubC6KFkavzbkaQhmYw7DuUk4boF54H++ZM6jhCEG2jslgujC8blNRhgDtzga4qTTcm+o7TAJKefJLQxS+w5QB+hZO6Fkqs01T/YlV1dx21FGqL2KZgXroeK6f1sOeo2UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 64C8D1C0129;
	Fri,  7 Aug 2026 20:26:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 7737920029;
	Fri,  7 Aug 2026 20:26:47 +0000 (UTC)
Date: Fri, 7 Aug 2026 16:26:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Meijing Zhao <zhaomeijing100@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/3] mm: trace: decode architecture-specific VMA
 flags
Message-ID: <20260807162650.39bc41f8@gandalf.local.home>
In-Reply-To: <20260807125054.d69baf2c6df589ddebbccd48@linux-foundation.org>
References: <20260723092905.761037-1-zhaomeijing100@gmail.com>
	<20260807031349.3119855-1-zhaomeijing100@gmail.com>
	<20260807084745.5d96995e@gandalf.local.home>
	<20260807125054.d69baf2c6df589ddebbccd48@linux-foundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: pb7y7h6mugxcu37sw8r56eyr713bs3bo
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 7737920029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/wtq6mZ3mj7GZKTASm39xBdeVTg10hpJI=
X-HE-Tag: 1786134407-711689
X-HE-Meta: U2FsdGVkX18pZZbuCnnOTQtC7FlA3k1Q2A4gaQfxbHuzzPjWoXlv3tbTvmitFGFZN1rgUXM7Oo52m4LdLgj+hnHKdIq5ATXDvIkDiVU3bGrbw9704RkY+bQV296ca6Lfjp8lEbgWZTXq5W1YTLUZKHkmrj7bENINWwyHlEsYCiDCRtREdfAZJ219p/EPbsse+Jawye1CqjFitUuvuY4rauO9Py5AJrVqRyh0hSxXN5MNT/CnwPWNoQEMeDdbEpYpNwqHe5F4jB8JvC6josSVhM+WN6a3vaotbVNN3Yx/SOxqaMkFbCHBQPHGgOn2fFESVPW9K4ojthogDSIV9A3Gc5/BzKFKj5BSMkeqp5qLSu+/JY7Swn+wYoFTHo8ewVXU

On Fri, 7 Aug 2026 12:50:54 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> get_maintainer isn't very useful with include/trace/events/mmflags.h.

Someone (probably me) needs to go through and add each of the files in
include/trace/events/* to their proper owner in the MAINTAINERS file :-p

-- Steve
