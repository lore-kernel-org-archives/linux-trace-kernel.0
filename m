Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D25243376;
	Fri, 23 Jan 2026 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188714; cv=none; b=oseBsvZs+salzAb7q/dRQNFSP6h6xcOxGHhJubxTxR0k0P0CBUU73FJAwEFQRFTOowqHRG+h1rGpUw4SS8p8O4tk1YcljJqjnnBd6+Cswvy58Y/VWQ9BwXQeL0fQGXrkNFSlXyhZAJZC+Vh03F8Dflr6aq284zU717yYYxACKB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188714; c=relaxed/simple;
	bh=BPDmo2pqNofRGg0Am4xMIVD2hUS+OETWGUGeD00A+JU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2jOVwWDNeFAU74O5GTdjT2YahJSdZ1LS+bJvikwMuP1XHxcFbEJ0nQW0p80csHJpNcoPBZAdA/o6/mgOaN1EAglgBAkRxA4ayU0UfjR0ZY6M9zLAOyWmUadWNSnn5S0TKdCOoIzYGACVAhM5NM2CwvTl5LIhOI1k0c8mSxqzwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 282D9140465;
	Fri, 23 Jan 2026 17:18:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 531342000D;
	Fri, 23 Jan 2026 17:18:30 +0000 (UTC)
Date: Fri, 23 Jan 2026 12:18:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>
Subject: Re: [PATCH v2] function_graph: Fix args pointer mismatch in
 print_graph_retval()
Message-ID: <20260123121858.0f7c3e98@gandalf.local.home>
In-Reply-To: <20260112021601.1300479-1-dolinux.peng@gmail.com>
References: <20260112021601.1300479-1-dolinux.peng@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 531342000D
X-Stat-Signature: wa8who3adj7a6xdednbhq3kzdph1hdu8
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18RcqiC1Y5tQ76WdJXjeI4sW5l71GxLZHo=
X-HE-Tag: 1769188710-469073
X-HE-Meta: U2FsdGVkX18ZTBzm6GDlX8ogsnU92j7G+mAX+RM/33Z7kEATWcdvUSUaJVBmEh/sPyOYkKJVh69QiXK3/MjvvRJLVBpGuSR6E4ldzXOS7sw9PmpsQ3e1f6vFL+mgmVNz7hWllwJGnmoCYsMOQTzHYmlQEbCKugL3Amh9/VIPa+fA7lyI2HeDMSE8M6u5tazSd9/XBsxxNKGWYcLGuAlRXN3J7rukWB8lsePk2v0LgRh9xb9sMpqNfZPo7m6YJQ/8WobUii7OjnUPSfJZaX5mvEr1oE9r04vN6t1KLVJgEOZ2exA7RPqro8uwjS4ZbovmiBgDp3Za/Iuas2eWrfKEDN0MkX2t9xSE8XDZp6Z4vUhUeZDWnQD+jqM4f5F0xeDU4DmSDY+x1MU=

On Mon, 12 Jan 2026 10:16:01 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> From: Donglin Peng <pengdonglin@xiaomi.com>
> 
> When funcgraph-args and funcgraph-retaddr are both enabled, many kernel
> functions display invalid parameters in trace logs[1].
> 
> The issue occurs because print_graph_retval() passes a mismatched args
> pointer to print_function_args(). Fix this by retrieving the correct
> args pointer using the FGRAPH_ENTRY_ARGS() macro.
> 
> [1] https://gitee.com/pengdonglin137/funcgraph_visualization/raw/master/samples/error_args.png

Please do not provide links to images. This stays in the git logs for the
lifetime of the Linux kernel. Images like this will likely not live as long
and the link becomes wasted space in the git history.

Either do a cut and paste of the bad output, or don't include it at all.

-- Steve


> Fixes: f83ac7544fbf ("function_graph: Enable funcgraph-args and funcgraph-retaddr to work simultaneously")
> Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
