Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADE23EFFB4;
	Fri, 26 Jun 2026 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782469850; cv=none; b=JKVVnTu3WtC98a+wiugSHntLhxMWAGWcNZlgz7pvLLtYdQ8wTDYY6MCzT5NZ3e3vWn7+1jtPw5/bSB6GQbKYmRAenWDFV4sVKRxeT4WXrhO1r6hYIy8/9j9JTo8+tc2PgmtTghUUA8GrWowaUumH+ihurz18Hr8GdA4gvLp9Y/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782469850; c=relaxed/simple;
	bh=l0uWrMiI3M6zkcQea77+jqTJiqJE2gPQrXElfWsZdKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPJW5BHXN9p6Ta4WQHCgcBAwqVpnqZpF0UuoyqH27tF25aj2AXqEqrAKkjBE0PHAiDqcjAGaOTKQS61050q6jKjSxwnInb6qrLeGlYC7xlqPaDe4lbxPpfXd89E60wbiShHq4gh/D20BO7Ett/GSmNZ06kgoYV1ULPs9YdzjLHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 357751C625E;
	Fri, 26 Jun 2026 10:23:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id AA7992002D;
	Fri, 26 Jun 2026 10:23:08 +0000 (UTC)
Date: Fri, 26 Jun 2026 06:23:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, "David Hildenbrand (Arm)"
 <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, linux-mm@kvack.org,
 willy@infradead.org, usama.arif@linux.dev, akpm@linux-foundation.org,
 mhocko@suse.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 kasong@tencent.com, qi.zheng@linux.dev, baohua@kernel.org,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chrisl@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com,
 baoquan.he@linux.dev, youngjun.park@lge.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/lruvec: trace LRU add drains and drain-all
 requests
Message-ID: <20260626062306.44f6de42@fedora>
In-Reply-To: <1136baf3-3967-4202-9eaa-5fd667c235cf@kernel.org>
References: <20260610195220.12403-1-jp.kobryn@linux.dev>
	<06122cae-e28b-4ded-a9dd-d380d31c5230@kernel.org>
	<ajK1YsIJmD2ImbAk@linux.dev>
	<1136baf3-3967-4202-9eaa-5fd667c235cf@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: pyndezwb7eabbyekeumw1ob6sds1hf5c
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: AA7992002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18i3ubSx5a0B1uVjoNYOjwVqf25DfQvgBI=
X-HE-Tag: 1782469388-195604
X-HE-Meta: U2FsdGVkX18dEIt/QbvxW1C1BDoR1JEG3lP5M8wHCqeCYL2cuvVnSTa+W0UiMILPlOZsA0zVyi/7ucWgezgIXkHfWj5C9FhlQKUWEZDdnmTE497HDjX4tAtMJ8Ep8WFLmwnMf8o9gu/8XDz4PQre1t+6+GtO24a3xEyPZ3UXIs3owq68uvXGRNQlHO0La0hdQkcu6ZsExDOlPsc3YJ+tvtnXqpKFdvt97Cwt04Sd46T7juRCDwPIw38cm7t+/glHmVjsUQxMU0Ba2p4ZzhWh2pcpBxJdq/tE9b0jeCPoNnwxMeTe1Z2N6NCpwN/tmRNSMC0zwPigPjULT6nkzV4jra5206sqnauchMLvU5pGTISuXyn4Iyswkg==

On Wed, 17 Jun 2026 20:18:57 +0200
"Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:

> Yeah and I don't recall ever that a change to a mm tracepoint would ever
> break someone who'd complain and we'd have to revert it. These are niche
> enough. So I think the risk is low.

Note, we have literally thousands of trace events already, so the
chances of one being required by an application is rather low.
Especially since access still requires root access, which limits it to
administration tooling.

That said, if you know of a tool that uses trace events, then those
that it is likely to use can become an ABI. For mm trace evnets,
rasdaemon is the tool to worry about.

-- Steve
