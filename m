Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEAF19E7ED
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919147; cv=none; b=UaCO3+PQ+0LXm4MjP66TOeIpnETjAv+aILc3tYKNbDqQFDO5Zyze6Dj/pFe5HpbFJ8Z/Kq1BpxvIHaeFIb0zkxF6Le1oh9k19tTwpaIf8miwAOH6BipIp68c/ar3uENtZ+BX8+XfNzh3FgJNasMOylT4KuT9b0/Vzjy2UAc4/iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919147; c=relaxed/simple;
	bh=7wPsQQtxBa/Tnh6/w55O/ra0mYkgNREJI0qgQ5Ji6hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jiMpjYB8ejCDicf3sor7g6eZ0QZGFcKPvf8871/urL0ufdnHVd/t18zvC3wBHqKC9T6r4AgE3EendbuoS6gWymmTw9+SB7HyyZewzwXUvm5Zo0qivIBnk158FKuyl0T6fwBmfj+8GStVw2mrHQaUzuRfYv4QFZ2KLtbhaL9MSS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908BAC4CEC7;
	Mon, 14 Oct 2024 15:19:06 +0000 (UTC)
Date: Mon, 14 Oct 2024 11:19:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ben Hutchings <benh@debian.org>
Cc: John Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: tools/rtla: Fix installation from out-of-tree build
Message-ID: <20241014111922.5f4fb778@gandalf.local.home>
In-Reply-To: <c075dbb7639d1c835b5fdb867462d6b455626e03.camel@debian.org>
References: <ZudubuoU_JHjPZ7w@decadent.org.uk>
	<5508e99b-f22e-ab01-61f0-4ae352e595d2@redhat.com>
	<c075dbb7639d1c835b5fdb867462d6b455626e03.camel@debian.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Oct 2024 22:34:49 +0200
Ben Hutchings <benh@debian.org> wrote:

> > Is Debian using out of tree builds Ben?  
> [...]
> 
> In the linux package specifically, yes, we try to do all builds out-of-
> tree.

Right. Out-of-tree builds is pretty much a must for anything in the Linux
kernel tree.

-- Steve
