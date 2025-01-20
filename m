Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4EA1F03F1;
	Mon, 20 Jan 2025 23:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737417185; cv=none; b=mzoflzFi+wGT+iHOU/6CNEuLwnRWgV/4xiBadssI0W8kX51Vdxsd9IUtxaBtwd5hXQ+IpW/cb1GRdbNaCyymGH9d/v/KDTEti12dbNzyY2rPjwwfVln2wiXvVS8O8o0pV4+PpfNviDdyxFodGSHCilR7/QlZC7Ew1DgFv1iJobc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737417185; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:From:To; b=p4kKoU/WVxiEUXqM5yPpj6ddJ71+ren9ZPZ0tFvplkXzRvxIqrCaScefRn4vEQfmbuVfCmKhGechN4jW53M5kBfY+s3qLUqnvISqrCK/WSReZ5Hmo8v61WCAkZpsJyXtb1Rn9CIcOAXslU0F/lXIWIca6QtSp+UaHVVJb0nNbXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9EAC4CEDD;
	Mon, 20 Jan 2025 23:53:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1ta1Zq-0000000091s-218a;
	Mon, 20 Jan 2025 18:53:06 -0500
Message-ID: <20250120234033.315619831@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 20 Jan 2025 18:40:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

