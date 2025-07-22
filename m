Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28526A0F8;
	Tue, 22 Jul 2025 22:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753224150; cv=none; b=U31z6yWfY7zE28Oqw4nwTYObZusrkE7NudtW6+jicLIaLuQc20xO4UQptLi9ivOSuV9p28df3guTFqDr1SXVMrZHKCaQhekvnHRNbx1vLXvEIlpqA7qNztjEpR5QUgB7yDf5w8pXoHLSgrJwgME4N3ttPZFDece6JzcBAAceg6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753224150; c=relaxed/simple;
	bh=E8qS2UJP7xzTkCk1g61fB6Lsrt4JCrgssiJBZSy527M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qo0IW9k1cU1CN3kjtmnfq1OkB/Df0qpYQlF9UXz/3ld9wYdWkDB79ppKU7KZ+EyVFoepScm+KIfuJbv582RA0+l7rZH1uVq4iYOIwuq7lOZVjMWZ5BUX0FO0OzW7DjgeH8rPnzP10kHwTYM+eeYUqiRbWbYBy86KKFagw6/MlRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 61B0D132A1A;
	Tue, 22 Jul 2025 22:42:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id BD0D420024;
	Tue, 22 Jul 2025 22:42:19 +0000 (UTC)
Date: Tue, 22 Jul 2025 18:42:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] tracing: uprobe-event: Allocate string buffers
 from heap
Message-ID: <20250722184219.2e16e288@gandalf.local.home>
In-Reply-To: <175322174554.44400.67987510323737083.stgit@devnote2>
References: <175322168606.44400.9155291012158349647.stgit@devnote2>
	<175322174554.44400.67987510323737083.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: w6tiqu5c9uit4a4mmoqb9ykq8utpumre
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: BD0D420024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19IMc4crnsQgGfC5US9IgTmgzIgjBiwLXo=
X-HE-Tag: 1753224139-776578
X-HE-Meta: U2FsdGVkX1/TxaA1f7R8PVYItBr/5UOaduf/Fx7mllgfnp/1xclEL+lS3O3zqfgRPvisMHMTuhoDv4GtuVVUyQOcZcLOew3PmFON9ComjvyO0/lUXyA24E73DjebQPIe6L6WgWh8/pBXJ3vhUiE4EDiP/sISyDDU3kpFM7DoJlFlcN7UV1kyuyaQLj8VHiNOG1ph5EcgxYYbi+Bvx/CPhGbkwvxrdrvAKCHiGEceZY+BvdAdwZQVoZJY8xTMnXBWFACy6SAD2C3CZ+bSZA4u5CBNVgF5/b3iRt0MDIom6CuvHSiQVg9FEfZnHZXUBeIqWlTBVeinseDyPnJk+e1EHHDOkoMJA6r4IhxXPCtpKccLwZr7uWiXSpIoLb0atjTVfbEbTfAjVXp9049s9LptWQ==

On Wed, 23 Jul 2025 07:02:25 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Allocate temporary string buffers for parsing uprobe-events
> from heap instead of stack.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
