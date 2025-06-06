Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD4C195FE8
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Jun 2025 02:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749178077; cv=none; b=KAwjQ2Dhd4NMGOl1wIa57lKHhyy/wsPqCENYIBW1y5vsRHvCnWuK1H6fUFFGGAY46nXzEMchdXa6tvolj4jpwg3bqKgb3ey/CHX5G1iXMPYZyN5ZGOMaS3CPqDlQB3+6cdQmqhPqft97RT2dJ7myhnQaysatuyVk6QjNH4emtvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749178077; c=relaxed/simple;
	bh=iXv1xdLvZbs7Nfb8UGZOhe0Mc9c1cYk2zhbO9w8s8lc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcBfdG7X4j5a7hi6aVReiaoGK/32wFU9rHnZQwUWHrL9YxeKs83bUI9IjIyBIXLNnmuwZ18tiGsB3q3UTOvjtP/9q7Xt4C+09/FCMLhkgIheheB92+zyddgUzIEsYKbP2LQuY95aGMEmKN1vTaz+z6Cn3gGZFGxbZ6aTH5PbCmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 64129C1C4F;
	Fri,  6 Jun 2025 02:47:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 9DB928000E;
	Fri,  6 Jun 2025 02:47:51 +0000 (UTC)
Date: Thu, 5 Jun 2025 22:49:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: yebin <yebin@huaweicloud.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 mark.rutland@arm.com, linux-trace-kernel@vger.kernel.org,
 yebin10@huawei.com
Subject: Re: [PATCH v3 1/2] ftrace: fix UAF when lookup kallsym after ftrace
 disabled
Message-ID: <20250605224911.5b9d0912@gandalf.local.home>
In-Reply-To: <684249C7.8050000@huaweicloud.com>
References: <20250529111955.2349189-1-yebin@huaweicloud.com>
	<20250529111955.2349189-2-yebin@huaweicloud.com>
	<20250602112823.4a83daa1@gandalf.local.home>
	<684249C7.8050000@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9DB928000E
X-Stat-Signature: x5ooy5a4nhxo86buf1mx7hnyhss6gpky
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/XU0gOpVFSqEBBYLZAWzKLFbn4od/MPJw=
X-HE-Tag: 1749178071-841747
X-HE-Meta: U2FsdGVkX18t/LbbEkQKjB1CMdD8Se+lAOYSCb6D9KvRGSAX1aKpGIZ09G7gP4oY1y2clp+9ZzerRu6pjEbhl95s+xHSAMRrmOTtMDb5mdhCj0zmT8C9mUF3jsFaWGQMaKgE8xOW46a3ZyYEXDbNE+Xsy0HuJg33MOGvGRpr9dPBAWzGZxHcLbIQUyAeFO+62H/dJylmjNklF0wSiPlZ6W3d0957B32bqRvD1/975ejt7Vp3HkI4mqb8TkZcVBBJarjzumLQLj12pUZj7rxsya49x5xKDPn7KF40RAq2ld0e4nWwGvFMyYJb4sIVFL0MV1xkr6x9hASzxeif+BVZCIyDNQ63EBiy0ltX8NYO58q34/Zybk9vyw==

On Fri, 6 Jun 2025 09:52:07 +0800
yebin <yebin@huaweicloud.com> wrote:

> Thank you very much for your detailed and clear explanation. Do I need 
> to send another version?

Nope, it's already been pulled into mainline:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f914b52c379c12288b7623bb814d0508dbe7481d

-- Steve
